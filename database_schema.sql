-- DATABASE SCHEMA: INVENTORY & POS MINIMARKET
CREATE DATABASE inventory_pos;
USE inventory_pos;

-- 1. Tabel Master Data
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'gudang', 'kasir') NOT NULL,
    status ENUM('Aktif', 'Nonaktif') DEFAULT 'Aktif'
);

CREATE TABLE kategori (
    id VARCHAR(50) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    deskripsi TEXT
);

CREATE TABLE satuan (
    id VARCHAR(50) PRIMARY KEY,
    nama VARCHAR(50) NOT NULL,
    singkatan VARCHAR(20) NOT NULL
);

CREATE TABLE supplier (
    id VARCHAR(50) PRIMARY KEY,
    kode VARCHAR(20) UNIQUE NOT NULL,
    nama VARCHAR(100) NOT NULL,
    telepon VARCHAR(20),
    alamat TEXT
);

-- 2. Tabel Barang (Foreign Keys Terhubung ke Master)
CREATE TABLE barang (
    id VARCHAR(50) PRIMARY KEY,
    kode VARCHAR(20) UNIQUE NOT NULL,
    nama VARCHAR(150) NOT NULL,
    kategori_id VARCHAR(50) NOT NULL,
    satuan_id VARCHAR(50) NOT NULL,
    supplier_id VARCHAR(50) NOT NULL,
    harga_beli DECIMAL(15,2) NOT NULL,
    harga_jual DECIMAL(15,2) NOT NULL,
    stok INT DEFAULT 0,
    minimum INT DEFAULT 0,
    FOREIGN KEY (kategori_id) REFERENCES kategori(id) ON UPDATE CASCADE,
    FOREIGN KEY (satuan_id) REFERENCES satuan(id) ON UPDATE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES supplier(id) ON UPDATE CASCADE
);

-- 3. Tabel Operasional (Gudang & Kasir)
CREATE TABLE histori_barang_masuk (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE NOT NULL,
    supplier_id VARCHAR(50),
    barang_id VARCHAR(50) NOT NULL,
    kuantitas INT NOT NULL,
    user_id VARCHAR(50),
    FOREIGN KEY (barang_id) REFERENCES barang(id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE transaksi_pos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    no_nota VARCHAR(50) UNIQUE NOT NULL,
    tanggal DATETIME NOT NULL,
    kasir_id VARCHAR(50) NOT NULL,
    total_harga DECIMAL(15,2) NOT NULL,
    bayar DECIMAL(15,2) NOT NULL,
    kembalian DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (kasir_id) REFERENCES users(id)
);

CREATE TABLE detail_transaksi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transaksi_id INT NOT NULL,
    barang_id VARCHAR(50) NOT NULL,
    qty INT NOT NULL,
    harga_satuan DECIMAL(15,2) NOT NULL,
    subtotal DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (transaksi_id) REFERENCES transaksi_pos(id) ON DELETE CASCADE,
    FOREIGN KEY (barang_id) REFERENCES barang(id)
);
