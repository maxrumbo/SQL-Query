--Maxwell Rumahorbo
--12S24037
--Sistem Informasi

CREATE TABLE Manager ( 
    manager_id INTEGER PRIMARY KEY,     
    manager_name VARCHAR(255),     
    salary DECIMAL(10,2) 
);
--Menambah data manager
INSERT INTO Manager (manager_id, manager_name, salary) 
VALUES (66928, 'Thomas', 5000.00), (65646, 'Merry', 7000.00), 
(67832, 'Adeline', 5500.00);

--Menambah atribut "commission" 
ALTER TABLE Manager  
ADD commission decimal(7,2); 

--Mengubah sallary
UPDATE Manager  
SET salary = 7500.00  
WHERE manager_id = 67832; 

-- Menampilkan data manager 
SELECT * FROM Manager; 

--Menampilkan  data manager dengan sallary >6000 dan nama diakhiri huruf "Y"
SELECT *  
FROM Manager  
WHERE salary > 6000  
AND manager_name LIKE '%Y'; 

-- Membuat tabel employee
CREATE TABLE Employee ( 
    emp_id INT PRIMARY KEY,     
    dep_id INT, 
    emp_name VARCHAR(50),     
    job_name VARCHAR(50),     
    manager_id INT,   
    hire_date DATE,     
    salary DECIMAL(10,2),     
    commission DECIMAL(10,2) 
); 

-- Memasukkan data ke tabel employee 
INSERT INTO Employee 
VALUES 
(64989, 3001, 'ADELYN', 'SALESMAN', 66928, '1991-02-20', 1700.00, 400.00), 
(65271, 3001, 'WADE', 'SALESMAN', 66928, '1991-02-22', 1350.00, 600.00), 
(67858, 3001, 'SCARLET', 'ANALYST', NULL, '1997-04-19', 3100.00, NULL), 
(68319, 1001, 'KAYLING', 'PRESIDENT', 67832, '1991-11-18', 6000.00, NULL), 
(68454, 3001, 'TUCKER', 'SALESMAN', 66928, '1991-09-08', 1600.00, NULL), 
(69324, 1001, 'MARKER', 'CLERK', 67832, '1992-01-23', 1400.00, NULL); 

-- Menampilkan data seluruh pegawai yang tidak memiliki nama pekerjaan sebagai CLERK dan ANALYST 
SELECT * FROM Employee 
WHERE job_name NOT IN ('CLERK', 'ANALYST');

--Menampilkan nama pekerjaan beserta jumlah pegawai dari setiap pekerjaan
SELECT job_name as JobName, COUNT(*) as NumEmployee 
FROM Employee GROUP BY job_name;  

--Menampilkan data gaji seluruh pegawai
SELECT 	emp_id, 
emp_name, salary  
 	FROM Employee; 

--Menampilkan data sallary grade dengan min sallary > 11500 atau max sallary > 2500

	CREATE TABLE SalaryGrade ( 
    grade INT PRIMARY KEY, 
    min_salary INT, 
    max_salary INT 
); 
 
--Menampilkan data sallary grade dengan min sallary > 11500 atau max sallary > 2500
SELECT * FROM SalaryGrade 
WHERE min_salary > 1500 AND max_salary > 2500; 

--Menampilkan data pegawai id awal pegawai 6 dan id akhir 4
SELECT *  
FROM Employee  
WHERE emp_id LIKE '6%4'; 

--Menampilkan id pegawai, nama pegawai, gaji, dan komisi
SELECT emp_id, emp_name, salary, commission  
FROM Employee; 

--Menampilkan id dan nama pegawai yang memiliki komisi
SELECT emp_id, emp_name  
FROM Employee  
WHERE commission IS NOT NULL;  

--Menampilkan nama pegawai, pekerjaan, dan dep_id 1001 dan 3001 
SELECT  
    emp_name AS NamaPegawai,     
	job_name AS NPekerjaan, 
    dep_id AS IDDepartement 
FROM Employee  
WHERE salary > 1500  
AND dep_id IN (1001, 3001); 

-- Menampilkan data pegawai yang tergabung sebelum 1992
SELECT * FROM Employee  
WHERE hire_date < '1992-01-01'; 

--Menampilkan rata-rata gaji dan total remunerasi per pekerjaan
SELECT  
    emp_id AS IDPegawai,     emp_name AS NamaPegawai, 
    salary AS Gaji, 
    (salary * 1.15) AS KenaikanGaji 
FROM Employee  
WHERE (salary * 1.15) > 2500; 

--Menampilkan rata-rata gaji dan total remunerasi per pekerjaan
SELECT  
    job_name AS NamaPekerjaan, 
    AVG(salary) AS AVGGaji, 
    AVG(salary + COALESCE(commission, 0)) AS AVGGajiKomisi 
FROM Employee  
GROUP BY job_name 
HAVING AVG(salary) > 1500 
ORDER BY job_name ASC; 

--Menampilkan data pegawai dengan kondisi khusus
SELECT emp_id, emp_name, job_name 
FROM Employee  
WHERE (salary + COALESCE(commission, 0)) * 12 < 25000 
AND commission IS NOT NULL  
AND commission <= salary 
AND job_name = 'SALESMAN' 

--Menampilkan id pegawai, nama pegawai, nama pekerjaan serta id manajer dimana id manajernya dimulai dari angka 6
SELECT emp_id, emp_name, job_name, manager_id
FROM employee
WHERE manager_id LIKE '6%';

--Menampilkan semua data yang komisi-nya adalah NULL. 
SELECT * FROM employee
WHERE commission IS NULL;




 

 





 




