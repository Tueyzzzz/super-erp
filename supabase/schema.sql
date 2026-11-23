-- Mini ERP: shared database for Supabase.
-- Run this once in your project's SQL Editor. It is safe to run again.

-- Who may use the ERP. Only emails listed here can read or change data.
create table if not exists public.erp_allowed_emails (
  email    text primary key check (email = lower(email)),
  added_at timestamptz not null default now()
);

-- All ERP records live in one table: col is the collection, data is the record.
create table if not exists public.erp_records (
  col        text not null check (col in ('products','customers','suppliers','sales','purchases')),
  id         text not null,
  data       jsonb not null,
  updated_at timestamptz not null default now(),
  updated_by uuid default auth.uid(),
  primary key (col, id)
);

-- True when the signed-in user's email is on the allow list.
create or replace function public.erp_is_allowed()
returns boolean
language sql stable security definer
set search_path = public
as $$
  select exists (
    select 1 from public.erp_allowed_emails
    where email = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

-- Record who changed a row and when.
create or replace function public.erp_touch()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  new.updated_by := auth.uid();
  return new;
end
$$;

drop trigger if exists erp_touch on public.erp_records;
create trigger erp_touch
  before insert or update on public.erp_records
  for each row execute function public.erp_touch();

-- Row level security
alter table public.erp_allowed_emails enable row level security;
alter table public.erp_records        enable row level security;

drop policy if exists "see own allow entry" on public.erp_allowed_emails;
create policy "see own allow entry" on public.erp_allowed_emails
  for select to authenticated
  using (email = lower(coalesce(auth.jwt() ->> 'email', '')));

drop policy if exists "approved can read"   on public.erp_records;
drop policy if exists "approved can insert" on public.erp_records;
drop policy if exists "approved can update" on public.erp_records;
drop policy if exists "approved can delete" on public.erp_records;

create policy "approved can read"   on public.erp_records for select to authenticated using (public.erp_is_allowed());
create policy "approved can insert" on public.erp_records for insert to authenticated with check (public.erp_is_allowed());
create policy "approved can update" on public.erp_records for update to authenticated using (public.erp_is_allowed()) with check (public.erp_is_allowed());
create policy "approved can delete" on public.erp_records for delete to authenticated using (public.erp_is_allowed());

-- Live updates: send changes on erp_records to open pages.
do $$
begin
  alter publication supabase_realtime add table public.erp_records;
exception when duplicate_object then null;
end
$$;

-- Approve people (lower-case emails). Change this to your own email and run it:
-- insert into public.erp_allowed_emails (email) values ('you@example.com');
