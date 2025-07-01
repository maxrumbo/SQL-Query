-- Maxwell Rumahorbo
-- 12S24037
-- SISTEM INFORMASI

CREATE DATABASE PresDB
ON 
PRIMARY (
    NAME = 'PresidentDBPrimary',
    FILENAME = 'D:\Create Database\DBS\0302\PressDB\PresDB.mdf', 
    SIZE = 10MB,
    MAXSIZE = 20MB,
    FILEGROWTH = 20%
),
(
    NAME = 'PresidentDBSecondary',
    FILENAME = 'D:\Create Database\DBS\0302\PressDB\PresDB.ndf',
    SIZE = 5MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 20%
)
LOG ON (
    NAME = 'PresidentDBLog',
    FILENAME = 'D:\Create Database\DBS\0302\PressDB\PresDB.ldf',
    SIZE = 30MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 20%
);

-- Cek file awal
SELECT 
    name AS FileName,
    physical_name AS FilePath,
    (size * 8 / 1024) AS Size_MB,                
    (max_size * 8 / 1024) AS MaxSize_MB,         
    (growth * 8 / 1024) AS Growth_MB,           
    type_desc AS FileType
FROM 
    sys.master_files
WHERE 
    database_id = DB_ID('PresDB');               

-- Perbesar MAXSIZE file log menjadi 60MB
ALTER DATABASE PresDB 
MODIFY FILE (
    NAME = PresidentDBLog,
    MAXSIZE = 60MB  
);

-- Cek lagi setelah perubahan
SELECT 
    name AS FileName,
    physical_name AS FilePath,
    (size * 8 / 1024) AS Size_MB,               
    (max_size * 8 / 1024) AS MaxSize_MB,        
    (growth * 8 / 1024) AS Growth_MB,            
    type_desc AS FileType
FROM 
    sys.master_files
WHERE 
    database_id = DB_ID('PresDB');             

-- Kembalikan MAXSIZE file log menjadi 50MB
ALTER DATABASE PresDB 
MODIFY FILE (
    NAME = PresidentDBLog,
    MAXSIZE = 50MB  
);

-- Cek lagi
SELECT 
    name AS FileName,
    physical_name AS FilePath,
    (size * 8 / 1024) AS Size_MB,                
    (max_size * 8 / 1024) AS MaxSize_MB,         
    (growth * 8 / 1024) AS Growth_MB,            
    type_desc AS FileType
FROM 
    sys.master_files
WHERE 
    database_id = DB_ID('PresDB');               

-- Tambahkan file ke filegroup default
ALTER DATABASE PresDB 
ADD FILE (
    NAME = PresidentDBSecondary2,
    FILENAME = 'D:\Create Database\DBS\0302\PressDB\PresDB2.ndf',  
    SIZE = 5MB,                  
    MAXSIZE = 10MB,              
    FILEGROWTH = 20%           
);

-- Tambahkan filegroup baru
ALTER DATABASE PresDB 
ADD FILEGROUP PresidentGroup;

-- Tambahkan file ke filegroup PresidentGroup
ALTER DATABASE PresDB 
ADD FILE 
(
    NAME = PresDB_1,
    FILENAME = 'D:\Create Database\DBS\0302\PressDB\PresDB1.ndf',  
    SIZE = 5MB,                   
    MAXSIZE = 10MB,              
    FILEGROWTH = 1MB
) 
TO FILEGROUP PresidentGroup;

-- Tambahkan file kedua ke filegroup PresidentGroup
ALTER DATABASE PresDB 
ADD FILE 
(
    NAME = PresDB_2,
    FILENAME = 'D:\Create Database\DBS\0302\PressDB\PresDB3.ndf',  
    SIZE = 5MB,                   
    MAXSIZE = 10MB,              
    FILEGROWTH = 1MB
) 
TO FILEGROUP PresidentGroup;

-- Menghapus file dari database
ALTER DATABASE PresDB 
REMOVE FILE PresDB_2; 

-- Cek semua file terakhir
SELECT 
    name AS FileName,
    physical_name AS FilePath,
    (size * 8 / 1024) AS Size_MB,                
    (max_size * 8 / 1024) AS MaxSize_MB,         
    (growth * 8 / 1024) AS Growth_MB,            
    type_desc AS FileType
FROM 
    sys.master_files
WHERE 
    database_id = DB_ID('PresDB');
	-- Hapus file PresDB_2 hanya jika masih ada

