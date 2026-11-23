// Shared database settings (Supabase).
// Leave both values empty to run in local demo mode, where data stays in each browser.
// The anon (or "publishable") key is meant to be public: who can read and write is
// enforced by the row level security rules in supabase/schema.sql.
window.ERP_CONFIG = {
  supabaseUrl: "",      // e.g. "https://abcdefghijklm.supabase.co"
  supabaseAnonKey: ""   // Project Settings → API Keys → anon / publishable key
};
