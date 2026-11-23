# Super ERP

ระบบ ERP ขนาดเล็กแบบหน้าเว็บเดียว (single-page app) เขียนด้วย HTML/CSS/JavaScript ล้วน ไม่ต้องติดตั้งอะไรเพิ่ม

A small single-page ERP written in plain HTML, CSS and JavaScript, with no build step.

## Features

- **Dashboard**: revenue collected, receivables, payables, inventory value, low stock, top customers, recent activity
- **Inventory**: products with SKU, cost, price, stock on hand and reorder point
- **Sales orders**: Draft → Confirmed → Shipped (takes stock out) → Paid
- **Purchasing**: Draft → Ordered → Received (adds stock) → Paid
- **Customers / Suppliers**: contact details with order counts and totals
- Responsive layout (desktop and phone) and dark mode

## Run locally

Open `index.html` in a browser, or serve the folder:

```bash
python -m http.server 8000
```

then go to http://localhost:8000.

## Data storage

The app picks where to keep data automatically:

| Mode | When | Who sees the data |
|---|---|---|
| **Supabase** (shared) | `config.js` has a Supabase URL and key | Everyone on the approved email list, with live updates |
| **Local demo** | `config.js` is empty | Only that browser (`localStorage`), starts with sample data |
| **Claude artifact** | Opened as a Claude artifact | Everyone the artifact is shared with |

## ตั้งค่าฐานข้อมูลกลาง (Supabase)

1. สมัคร / ล็อกอินที่ https://supabase.com แล้วกด **New project** (แพ็กเกจฟรีใช้ได้)
2. ไปที่ **SQL Editor** วางเนื้อหาไฟล์ [`supabase/schema.sql`](supabase/schema.sql) แล้วกด **Run**
3. เพิ่มอีเมลที่อนุญาตให้ใช้งาน (ใช้ตัวพิมพ์เล็ก) แล้วกด **Run**
   ```sql
   insert into public.erp_allowed_emails (email) values ('you@example.com');
   ```
4. (ไม่บังคับ) ถ้าอยากได้ข้อมูลตัวอย่าง ให้รันไฟล์ [`supabase/seed.sql`](supabase/seed.sql)
5. ไปที่ **Authentication → URL Configuration**
   - **Site URL**: `https://tueyzzzz.github.io/super-erp/`
   - **Redirect URLs**: เพิ่ม `https://tueyzzzz.github.io/super-erp/` (และ `http://localhost:8000/` ถ้าจะทดสอบในเครื่อง)
6. ไปที่ **Project Settings → API Keys** คัดลอก **Project URL** และ **anon / publishable key** มาใส่ใน [`config.js`](config.js)
7. commit แล้ว push ขึ้น `main` จากนั้น GitHub Pages จะอัปเดตเว็บเอง

**การเพิ่มคนใช้งาน:** เพิ่มอีเมลในตาราง `erp_allowed_emails` ผ่าน Table Editor หรือ SQL คนนั้นจะล็อกอินด้วยลิงก์ที่ส่งไปทางอีเมลได้

**ความปลอดภัย:** anon key เปิดเผยได้ตามการออกแบบของ Supabase เพราะสิทธิ์อ่านและเขียนถูกควบคุมด้วย Row Level Security ใน `schema.sql` ห้ามใส่ **service_role / secret key** ใน `config.js` เด็ดขาด

## Ideas for next steps

- Roles (for example read-only users)
- Tax and multi-currency
- Invoice PDFs
- Accounting (general ledger)
