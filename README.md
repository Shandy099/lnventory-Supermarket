# StockPilot — Sistem Inventory & POS (Prototipe Master Data)

Proyek front-end untuk modul Master Data: CRUD Barang, Satuan, Kategori Produk, Supplier, dan Manajemen Pengguna.

## Cara menjalankan

1. Ekstrak ZIP proyek.
2. Buka folder `inventory-pos-masterdata` di Visual Studio Code.
3. Jalankan `index.html` menggunakan ekstensi **Live Server**. Alternatifnya, buka `index.html` langsung di browser; Live Server lebih disarankan.
4. Masuk menggunakan akun demo berikut:

| Role | Username | Password |
|---|---|---|
| Admin | `admin` | `admin123` |
| Gudang | `gudang` | `gudang123` |
| Kasir | `kasir` | `kasir123` |

## Fitur yang tersedia

- Login, logout, dan toggle tampil/sembunyikan password.
- Dashboard ringkas untuk jumlah barang, kategori, supplier, dan stok rendah.
- CRUD Data Barang dengan kode, nama, kategori, satuan, supplier, harga beli, harga jual, stok, dan stok minimum.
- CRUD Satuan, Kategori Produk, Supplier, dan Manajemen Pengguna.
- Pencarian data di setiap modul.
- Validasi data wajib, kode/username duplikat, dan validasi relasi barang terhadap kategori/satuan/supplier.
- Pencegahan penghapusan kategori, satuan, atau supplier yang masih dipakai oleh barang.
- Pembatasan tampilan menu menurut role: Admin dapat mengelola semua modul; Gudang dapat mengelola data master operasional; Kasir hanya dapat melihat data barang.
- Penyimpanan demo pada `localStorage` sehingga data tetap ada di browser yang sama.

## Struktur folder

```text
inventory-pos-masterdata/
├── index.html
├── dashboard.html
├── master-data.html
├── css/
│   └── style.css
└── js/
    ├── auth.js
    ├── data.js
    ├── dashboard.js
    └── master-data.js
```

## Catatan penting

Ini adalah prototipe front-end untuk demo atau tugas kuliah, bukan sistem produksi. Data, termasuk password akun demo, disimpan di `localStorage` browser dan tidak aman untuk penggunaan nyata. Aplikasi produksi perlu backend/API, database, password hashing di server, validasi server-side, dan pemeriksaan hak akses di server. Bootstrap dan Bootstrap Icons menggunakan CDN sehingga koneksi internet dibutuhkan untuk memuat tampilannya.
