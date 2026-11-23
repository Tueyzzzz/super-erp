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

- Opened as a normal web page, data is saved in the browser's `localStorage` (per browser, per device) and starts with demo data.
- Published as a Claude artifact, it uses the artifact's shared database so changes sync between everyone with access.

## Ideas for next steps

- User accounts and roles
- Tax and multi-currency
- Invoice PDFs
- Accounting (general ledger)
- A real backend (e.g. Next.js with a database)
