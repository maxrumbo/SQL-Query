USE master;
GO
ALTER DATABASE cis_itdel SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE cis_itdel;
GO



-- 1. Membuat database
CREATE DATABASE cis_itdel;
GO

-- 2. Menggunakan database
USE cis_itdel;
GO

-- 3. Membuat tabel-tabel

-- Tabel User
-- CREATE
CREATE TABLE users (
    id_user VARCHAR(10) PRIMARY KEY,
    nama NVARCHAR(100),
    username NVARCHAR(50),
    role NVARCHAR(20)
);

-- INSERT
INSERT INTO users (id_user, nama, username, role) VALUES
('A001', 'Boy', 'BgMora', 'Admin'),
('U002', 'Kaleh', 'Kaleh01', 'user'),
('U003', 'Rony', 'BlackRny', 'user');

SELECT * FROM users;

--Select
SELECT id_user, nama, username, role
FROM users
WHERE role LIKE 'user';

-- Update
UPDATE users
SET username = 'BangBlack'
WHERE id_user = 'U003';

--Set Operators
SELECT nama AS name FROM users
UNION 
SELECT judul AS name FROM pengumuman;

--Aggregate function
SELECT COUNT (*) AS total_nama 
FROM users;

--NULL Value
SELECT id_user, nama
FROM users
WHERE role is NULL;

--Implementing View 
CREATE VIEW view_users
AS
SELECT 
    id_user,
    nama,
    username,
    role
FROM users
WHERE role = 'user';

SELECT * FROM view_users;

CREATE VIEW view_pengumuman_dengan_user
AS
SELECT 
    p.id_pengumuman,
    p.judul,
    p.kategori,
    p.tanggal_pembuatan,
    p.tanggal_berakhir,
    u.id_user,
    u.nama AS nama_user,
    u.username
FROM pengumuman p
INNER JOIN users u ON p.id_user = u.id_user;

	

CREATE VIEW view_user_dan_pengumuman
AS
SELECT 
    u.id_user,
    u.nama,
    u.username,
    u.role,
    p.id_pengumuman,
    p.judul,
    p.kategori,
    p.tanggal_pembuatan,
    p.tanggal_berakhir
FROM users u
LEFT JOIN pengumuman p ON u.id_user = p.id_user;

SELECT * FROM view_user_dan_pengumuman;

-- CREATE
CREATE TABLE pengumuman (
    id_pengumuman VARCHAR(10) PRIMARY KEY,
    id_user VARCHAR(10),
    judul NVARCHAR(200),
    kategori NVARCHAR(100),
    tanggal_pembuatan DATE,
    tanggal_berakhir DATE,
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO pengumuman (id_pengumuman, id_user, judul, kategori, tanggal_pembuatan, tanggal_berakhir) VALUES
('P001', 'A001', 'Pengumuman A', 'Kategori 1', '2023-01-01', '2023-01-10'),
('P002', 'U002', 'Pengumuman B', 'Kategori 2', '2023-01-02', '2023-01-15'),
('P003', 'A001', 'Pengumuman C', 'Kategori 1', '2023-01-03', '2023-01-20');

SELECT * FROM pengumuman;

-- Select
SELECT id_pengumuman, id_user, judul, kategori, tanggal_pembuatan, tanggal_berakhir
FROM pengumuman
WHERE kategori LIKE 'Kategori 1'
-- Update 
UPDATE pengumuman 
SET judul = 'Pengumuman Kehilangan Tumbler'
WHERE id_user =  'U002';

--Aggregate function
SELECT COUNT (*) AS total_judul 
FROM pengumuman;

-- NULL Value
SELECT id_pengumuman, id_user, judul
FROM pengumuman
WHERE judul IS NULL;

-- Inner Join Tabel User dan Pengumuman
SELECT 
    pengumuman.id_pengumuman,
    pengumuman.judul,
    pengumuman.kategori,
    pengumuman.tanggal_pembuatan,
    users.id_user,
    users.nama,
    users.username,
    users.role
FROM pengumuman
INNER JOIN users ON pengumuman.id_user = users.id_user;

--Left Join Tabel User dan Pengumuman
SELECT 
    users.id_user,
    users.nama,
    users.username,
    users.role,
    pengumuman.id_pengumuman,
    pengumuman.judul,
    pengumuman.kategori,
    pengumuman.tanggal_pembuatan,
    pengumuman.tanggal_berakhir
FROM users
LEFT JOIN pengumuman ON users.id_user = pengumuman.id_user;

--Cross Join Tabel User dan Pengumuman
SELECT 
    users.id_user,
    users.nama,
    users.username,
    users.role,
    pengumuman.id_pengumuman,
    pengumuman.judul,
    pengumuman.kategori,
    pengumuman.tanggal_pembuatan,
    pengumuman.tanggal_berakhir
FROM users
CROSS JOIN pengumuman;

--Function Menghitung Jumlah Pengumuman
CREATE FUNCTION hitung_jumlah_pengumuman()
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(*) FROM pengumuman);
END;
SELECT COUNT(*) FROM pengumuman;

-- Function 
CREATE FUNCTION get_nama_user(@id_user VARCHAR(10))
RETURNS VARCHAR(100)
AS
BEGIN
    RETURN (SELECT nama FROM users WHERE id_user = @id_user);
END;

SELECT dbo.get_nama_user('A001');
-- Stored Procedure 
CREATE PROCEDURE UpdateJudulPengumuman
    @id_pengumuman VARCHAR(10),
    @judul_baru NVARCHAR(200)
AS
BEGIN
    UPDATE pengumuman
    SET judul = @judul_baru
    WHERE id_pengumuman = @id_pengumuman;
END;

EXEC UpdateJudulPengumuman 'P001', 'Besok Libur';

SELECT * FROM pengumuman;
-- CREATE
CREATE TABLE survey (
    id_survey VARCHAR(10) PRIMARY KEY,
    id_user VARCHAR(10),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO survey (id_survey, id_user) VALUES
('S001', 'A001'),
('S002', 'U002'),
('S003', 'U003');

SELECT * FROM survey;
-- Set Operators
SELECT id_survey AS name FROM survey
UNION
SELECT judul_kuesioner AS name FROM kuesioner;

-- CREATE
CREATE TABLE kuesioner (
    id_kuesioner VARCHAR(10) PRIMARY KEY,
    id_user VARCHAR(10),
    judul_kuesioner NVARCHAR(200),
    tahun_ajaran VARCHAR(10),
    semester_ta VARCHAR(10),
    status_kuesioner NVARCHAR(50),
    kategori NVARCHAR(100),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO kuesioner (id_kuesioner, id_user, judul_kuesioner, tahun_ajaran, semester_ta, status_kuesioner, kategori) 
VALUES
('K001', 'A001', 'Kuesioner A', '2023/2024', 'Ganjil', 'Aktif', 'Akademik');

SELECT * FROM kuesioner;

-- CREATE
CREATE TABLE peminjaman_alat (
    id_peminjaman VARCHAR(10) PRIMARY KEY,
    nama_alat NVARCHAR(100),
    jumlah_alat INT,
    stock_tersedia INT,
    tujuan NVARCHAR(MAX),
    rencana_peminjaman DATE,
    rencana_pengembalian DATE,
    status_peminjaman NVARCHAR(50),
    id_user VARCHAR(10),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO peminjaman_alat (id_peminjaman, nama_alat, jumlah_alat, stock_tersedia, tujuan, rencana_peminjaman, rencana_pengembalian, status_peminjaman, id_user) VALUES
('PM001', 'Alat A', 2, 10, 'Tujuan A', '2023-02-01', '2023-02-07', 'dipinjam', 'A001'),
('PM002', 'Alat B', 5, 7, 'Tujuan B', '2023-02-10', '2023-02-17', 'tersedia', 'U002'),
('PM003', 'Alat C', 3, 4, 'Tujuan C', '2023-02-15', '2023-02-20', 'dipinjam', 'U003');

SELECT * FROM peminjaman_alat;
--Nested Queries 1
SELECT nama_alat, tujuan
FROM peminjaman_alat
WHERE tujuan = (
    SELECT tujuan
    FROM peminjaman_alat
    WHERE id_peminjaman = 'PM001'
);

SELECT tujuan
FROM peminjaman_alat
WHERE id_user IN (
    SELECT id_user
    FROM peminjaman_alat
    WHERE id_user = 'A001'
);




-- CREATE
CREATE TABLE pemesanan_bahan (
    id_pemesanan VARCHAR(10) PRIMARY KEY,
    id_user VARCHAR(10),
    nama_bahan NVARCHAR(100),
    jumlah_bahan INT,
    stock_tersedia INT,
    tujuan NVARCHAR(MAX),
    rencana_pemakaian DATE,
    total_harga INT,
    status_pemesanan NVARCHAR(50),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO pemesanan_bahan (id_pemesanan, id_user, nama_bahan, jumlah_bahan, stock_tersedia, tujuan, rencana_pemakaian, total_harga, status_pemesanan) VALUES
('P001', 'A001', 'Bahan A', 10, 50, 'Penggunaan A', '2023-03-01', 100000, 'aktif'),
('P002', 'U002', 'Bahan B', 20, 40, 'Penggunaan B', '2023-03-05', 200000, 'selesai'),
('P003', 'U003', 'Bahan C', 15, 30, 'Penggunaan C', '2023-03-10', 150000, 'aktif');

SELECT * FROM pemesanan_bahan;
-- Stored Procedure

CREATE PROCEDURE GetStatusPemesanan
    @id_pemesanan VARCHAR(50)
AS
BEGIN
    SELECT id_pemesanan, nama_bahan, jumlah_bahan, status_pemesanan
    FROM pemesanan_bahan
    WHERE id_pemesanan = @id_pemesanan;
END;

EXEC GetStatusPemesanan 'P001';

SELECT * FROM pemesanan_bahan;

-- CREATE
CREATE TABLE paket (
    id_paket VARCHAR(10) PRIMARY KEY,
    id_user VARCHAR(10),
    pengirim NVARCHAR(100),
    nama_penerima NVARCHAR(100),
    deskripsi NVARCHAR(MAX),
    status_paket NVARCHAR(50),
    waktu_kedatangan DATE,
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO paket (id_paket, id_user, pengirim, nama_penerima, deskripsi, status_paket, waktu_kedatangan) VALUES
('PK001', 'A001', 'Pengirim A', 'Penerima A', 'Deskripsi A', 'terkirim', '2023-04-01'),
('PK002', 'U002', 'Pengirim B', 'Penerima B', 'Deskripsi B', 'dalam perjalanan', '2023-04-05'),
('PK003', 'U003', 'Pengirim C', 'Penerima C', 'Deskripsi C', 'terkirim', '2023-04-10');

SELECT * FROM paket;
DROP TABLE ticketing;

-- CREATE
CREATE TABLE ticketing (
    id_ticketing VARCHAR(10) PRIMARY KEY,
    id_user VARCHAR(10),
    judul_ticketing NVARCHAR(200),
    bagian NVARCHAR(100),
    lokasi NVARCHAR(100),
    tanggal_ticketing DATE,
    status_ticketing NVARCHAR(50),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO ticketing (id_ticketing, id_user, judul_ticketing, bagian, lokasi, tanggal_ticketing, status_ticketing) VALUES
('T001', 'A001', 'Ticket A', 'Bagian A', 'Lokasi A', '2023-05-01', 'aktif'),
('T002', 'U002', 'Ticket B', 'Bagian B', 'Lokasi B', '2023-05-02', 'ditutup'),
('T003', 'U003', 'Ticket C', 'Bagian C', 'Lokasi C', '2023-05-03', 'aktif');

SELECT * FROM ticketing;

-- CREATE
CREATE TABLE polling (
    id_polling VARCHAR(10) PRIMARY KEY,
    id_user VARCHAR(10),
    judul_polling NVARCHAR(200),
    pertanyaan NVARCHAR(MAX),
    opsi_jawaban NVARCHAR(MAX),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO polling (id_polling, id_user, judul_polling, pertanyaan, opsi_jawaban) VALUES
('PO001', 'A001', 'Polling A', 'Pertanyaan A', 'Opsi A'),
('PO002', 'U002', 'Polling B', 'Pertanyaan B', 'Opsi B'),
('PO003', 'U003', 'Polling C', 'Pertanyaan C', 'Opsi C');

SELECT * FROM polling;

-- CREATE
CREATE TABLE laboratorium (
    id_laboratorium VARCHAR(10) PRIMARY KEY,
    id_user VARCHAR(10),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

-- INSERT
INSERT INTO laboratorium (id_laboratorium, id_user) VALUES
('L001', 'A001'),
('L002', 'U002'),
('L003', 'U003');

SELECT * FROM laboratorium;

--SELECT
SELECT id_user,
