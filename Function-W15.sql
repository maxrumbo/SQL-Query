--Maxwell Rumahorbo
--12S24037
--Sistem Informasi

create table product (
    prod_nr int not null,
    constraint pk_product primary key(prod_nr),
    Name varchar(30) not null,
    price Money not null,
    type varchar(30) not null
);

insert into product (prod_nr, name, Price, type)
values 
    (1, 'tv', 500, 'electronics'),
    (2, 'radio', 100, 'electronics'),
    (3, 'ball', 100, 'sports'),
    (4, 'racket', 200, 'sports');

--Show product records
select*from product

--Exercise 1
CREATE FUNCTION dbo.fn_check_stock (@product_name VARCHAR(30))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @message VARCHAR(100);

    IF EXISTS (
        SELECT 1 FROM product 
        WHERE LOWER(name) = LOWER(@product_name)
    )
        SET @message = 'There are ' + @product_name + ' in stock.';
    ELSE
        SET @message = 'There are no ' + @product_name + ' in stock.';

    RETURN @message;
END;

--Test
select dbo.fn_check_stock ('book');
select dbo.fn_check_stock ('TV');

--Exercise 2

CREATE FUNCTION dbo.fn_avg_price_sports (@input_price MONEY)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @avg_price MONEY
    DECLARE @result VARCHAR(100)

    SELECT @avg_price = AVG(price)
    FROM product
    WHERE type = 'sports'

    IF @avg_price > @input_price
        SET @result = 'The average price of products is greater than ' + CAST(@input_price AS VARCHAR)
    ELSE IF @avg_price < @input_price
        SET @result = 'The average price of products is less than ' + CAST(@input_price AS VARCHAR)
    ELSE
        SET @result = 'The average price of products is equals to ' + CAST(@input_price AS VARCHAR)

    RETURN @result
END

select AVG(Price) as 'Average Price Sports' from product where type like 'sports'

--Test
select dbo.fn_avg_price_sports (100.00)

--Test
select dbo.fn_avg_price_sports (150.00)

--Test
select dbo.fn_avg_price_sports (400.00)

--Exercise 3
CREATE FUNCTION dbo.fn_update_price_until_avg (@target_avg_price FLOAT)
RETURNS @Result TABLE (
    prod_id INT,
    price FLOAT
)
AS
BEGIN
    DECLARE @Temp TABLE (
        prod_id INT,
        price FLOAT
    );

    -- Copy data awal dari tabel product
    INSERT INTO @Temp (prod_id, price)
    SELECT prod_nr, Price FROM product;

    -- Hitung rata-rata awal
    DECLARE @avg_price FLOAT;
    SELECT @avg_price = AVG(price) FROM @Temp;

    -- Loop hingga rata-rata > target
    WHILE @avg_price <= @target_avg_price
    BEGIN
        UPDATE @Temp
        SET price = price * 1.1;

        SELECT @avg_price = AVG(price) FROM @Temp;
    END

    -- Masukkan hasil akhir ke @Result
    INSERT INTO @Result
    SELECT * FROM @Temp;

    RETURN;
END


--Test

-- 1. Lihat isi tabel product sebelum update
SELECT * FROM product;

-- 2. Lihat average price awal
SELECT AVG(Price) AS AVG_PRICE FROM product;

-- 3. Jalankan fungsi untuk lihat hasil akhir update
SELECT * FROM dbo.fn_update_price_until_avg(500);

-- 4. Bisa tambahkan juga: average price setelah update
SELECT AVG(price) AS AVG_PRICE FROM dbo.fn_update_price_until_avg(500);




