# haos-grokbot-gateway-proxy

Home Assistant OS add-on store: reverse proxy ที่ส่งต่อ traffic ไปยัง **GrokBot gateway**
(บนเครื่อง grokbot / atomgrok.commu.oracle) ผ่านเมช NetBird commu

ฝากโดย: พี่นัท (Oracle School) · สร้างโดย Atom Oracle · กันยายน 2026

## ทำไมต้องมี

- GrokBot gateway ฟังอยู่บนเครื่อง grokbot (`100.64.142.60:1340`) เฉพาะในเมชเท่านั้น
- เครื่อง/เครื่องมือฝั่ง haos-school ที่อยากเรียกใช้ gateway จะได้ endpoint เดียวที่นิ่ง
  คือ `http://<haos-school>:8140` โดยไม่ต้องรู้ IP upstream เอง
- เปลี่ยน upstream (เช่น grokbot ย้าย IP) ได้จากหน้า options ของ add-on โดยไม่แตะ config ใครเลย

## ติดตั้ง

Settings → Add-ons → Add-on Store → ⋮ → Repositories ใส่:

```
https://github.com/thebuilderofmoebius9/haos-grokbot-gateway-proxy
```

แล้วค้น "GrokBot Gateway Proxy" → Install → ตั้ง options → Start

## Options

- `upstream_host` — IP/ชื่อ gateway ปลายทาง (default `100.64.142.60`)
- `upstream_port` — พอร์ต gateway (default `1340`)
- `auth_token` — (ไม่บังคับ) bearer token ที่จะฉีดให้เมื่อ caller ไม่ได้ส่ง header
  `Authorization` มาเอง ถ้าปล่อยว่าง = ส่งต่อแบบ pass-through ล้วน ๆ
  (token ไม่เคยถูกพิมพ์ลง log)

## พฤติกรรม

- ส่งต่อทุก path ทุก method ไป upstream ครบถ้วน (รวม `Authorization` ของ client)
- `GET /proxy-health` คือ health ของ nginx เอง (ไม่แตะ upstream)
- timeout ยาว 5 นาที สำหรับ prompt ที่ตอบช้า
- รับ body สูงสุด 5MB

## ข้อจำกัด / ข้อควรรู้

- ตัว gateway ปลายทางบังคับ bearer token อยู่แล้ว (ยืนยันด้วยการยิงจริง:
  `POST /api/sendPrompt` ไม่มี token → 401) มีเพียง `GET /health` ที่เปิด
- add-on นี้ไม่มี auth ของตัวเอง — ความปลอดภัยพึ่งพา (1) เครือข่ายเมชและ
  (2) token ของ gateway
