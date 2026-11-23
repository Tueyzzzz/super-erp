-- Optional: sample data so the ERP doesn't start empty.
-- Run after schema.sql. Rows that already exist are left alone.
insert into public.erp_records (col, id, data) values
  ('products','chr-100','{"sku":"CHR-100","name":"Ergonomic office chair","category":"Furniture","unit":"pcs","cost":92,"price":189,"stock":24,"reorder":10}'),
  ('products','dsk-200','{"sku":"DSK-200","name":"Standing desk 140cm","category":"Furniture","unit":"pcs","cost":210,"price":429,"stock":8,"reorder":5}'),
  ('products','mon-27','{"sku":"MON-27","name":"27\" 4K monitor","category":"Electronics","unit":"pcs","cost":180,"price":329,"stock":15,"reorder":8}'),
  ('products','kbd-01','{"sku":"KBD-01","name":"Wireless keyboard","category":"Electronics","unit":"pcs","cost":22,"price":49,"stock":60,"reorder":25}'),
  ('products','cbl-usbc','{"sku":"CBL-USBC","name":"USB-C cable 2m","category":"Accessories","unit":"pcs","cost":3,"price":12,"stock":140,"reorder":50}'),
  ('products','lmp-10','{"sku":"LMP-10","name":"LED desk lamp","category":"Accessories","unit":"pcs","cost":14,"price":39,"stock":4,"reorder":10}'),
  ('customers','c1','{"name":"Northwind Studio","email":"buy@northwind.example","phone":"555-0101","city":"Portland"}'),
  ('customers','c2','{"name":"Bluebird Clinics","email":"ops@bluebird.example","phone":"555-0144","city":"Denver"}'),
  ('customers','c3','{"name":"Harbor Legal LLP","email":"office@harbor.example","phone":"555-0190","city":"Boston"}'),
  ('suppliers','s1','{"name":"Atlas Furniture Co.","email":"sales@atlas.example","phone":"555-0210","city":"Grand Rapids"}'),
  ('suppliers','s2','{"name":"Volt Components","email":"orders@volt.example","phone":"555-0233","city":"San Jose"}'),
  ('sales','so1','{"number":"SO-0001","customerId":"c1","date":"2026-11-02","status":"paid","lines":[{"productId":"chr-100","qty":6,"price":189},{"productId":"kbd-01","qty":6,"price":49}]}'),
  ('sales','so2','{"number":"SO-0002","customerId":"c2","date":"2026-11-10","status":"shipped","lines":[{"productId":"mon-27","qty":4,"price":329},{"productId":"cbl-usbc","qty":10,"price":12}]}'),
  ('sales','so3','{"number":"SO-0003","customerId":"c3","date":"2026-11-18","status":"confirmed","lines":[{"productId":"dsk-200","qty":3,"price":429}]}'),
  ('purchases','po1','{"number":"PO-0001","supplierId":"s1","date":"2026-11-05","status":"received","lines":[{"productId":"chr-100","qty":20,"price":92}]}'),
  ('purchases','po2','{"number":"PO-0002","supplierId":"s2","date":"2026-11-19","status":"ordered","lines":[{"productId":"lmp-10","qty":30,"price":14},{"productId":"mon-27","qty":10,"price":180}]}')
on conflict (col, id) do nothing;
