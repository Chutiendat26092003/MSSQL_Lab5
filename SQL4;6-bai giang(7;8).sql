--SQL4
USE master
GO

IF(DB_ID('Example4') IS NOT NULL)
DROP DATABASE Example4 

CREATE DATABASE Example4
ON PRIMARY
(
    NAME = N'Customer_DB',
	FILENAME = N'E:\FPT-Aptech\SQL\Example4.mdf'
)
LOG ON 
(
    NAME = N'Customer_DB_log',
	FILENAME = N'E:\FPT-Aptech\SQL\Example4_DB_log.ldf'
)
COLLATE  SQL_Latin1_General_CP1_CI_AS
GO

USE Example4
GO

ALTER DATABASE Example4 MODIFY NAME = Example4Test
GO

USE Example4Test
GO
 
EXECUTE sp_changedbowner @loginame = 'sa' -- thay đổi chủ owner 
EXEC sp_changedbowner 'sa'
GO

USE Example4Test
GO
ALTER DATABASE CUST_DB SET AUTO_SHRINK ON -- thêm 1 tùy chọn 



--/////////
--SQL6
CREATE DATABASE Example5
GO

USE Example5
GO

-- tạo bảng LopHoc sử dụng PRIMARY và IDENTITY 
CREATE TABLE LopHoc(
     MaLopHoc INT PRIMARY KEY IDENTITY, -- kiểu dư liệu là int k được trùng lặp, tự tăng từ 1 vì k được quy định 
	 TenLopHoc VARCHAR(10) --sô lượng ký tự là 10
)
GO

-- tạo bảng SinhVien có khóa ngoại là cột MaLopHoc, nối với bảng LopHoc
CREATE TABLE SinhVien(
     MaSV INT PRIMARY KEY,
	 TenSV VARCHAR(40),
	 MaLopHoc int,
	 CONSTRAINT fk FOREIGN KEY (MaLopHoc)  REFERENCES LopHoc(MaLopHoc)
)
GO

-- tạo bảng SanPham với cột NULL, một cột NOT NULL
CREATE TABLE SanPham (
    MaSP int NOT Null, -- không cho phép để trống 
	TenSP varchar(40) NULL -- cho phép để trống 
)
GO

-- tạo bảo với thuộc tính DEFAULT cho cột Price
CREATE TABLE StoreProduct1(
     ProductID int NOT NULL,
	 NameS varchar(40) NOT NULL,
	 Price money NOT NULL DEFAULT(100)
)
INSERT INTO StoreProduct1 (ProductID, NameS) VALUES (111, 'Rives')
SELECT * FROM StoreProduct1
GO

-- tạo bảng với thuộc tính IDENTITY 
CREATE TABLE ContactPhone(
    Person_ID  int IDENTITY(500, 1) NOT NULL,
	MobileNumber bigint NOT NULL
)
INSERT INTO ContactPhone(MobileNumber) VALUES (392625);
SELECT * FROM ContactPhone
GO

-- tạo cột nhận dạng duy nhất tổng thể 
CREATE TABLE CelluarPhone(
    Person_ID uniqueidentifier DEFAULT NEWID() NOT NULL,
	PersonName varchar(60) NOT NULL
)
INSERT INTO CelluarPhone(PersonName) VALUES ('William Smith2')
SELECT * FROM CelluarPhone
GO

--  tạo bảng với thuộc tính UNIQUE
CREATE TABLE ContactPhone1 (
    Person_ID int PRIMARY KEY, --không trùng lặp 
	MobileNumber bigint UNIQUE, -- không trùng lặp nhưng được có 1 giá trị NULL 
	ServiceProvider varchar(30),
	LandlineNumber bigint UNIQUE -- không trùng lặp nhưng được có 1 giá trị NULL 
)
INSERT INTO ContactPhone1 VALUES (11, 123456, 'Hutch', NULL)
INSERT INTO ContactPhone1 VALUES (12, 1234567, 'Alex',  22)

SELECT * FROM ContactPhone1
GO

-- tạo bảng có một CHECK ở cột Amount 
CREATE TABLE PhoneExpenses (
   Expense_ID int PRIMARY KEY,
   MobileNumber bigint FOREIGN KEY REFERENCES ContactPhone1(MobileNumber),
   Amount bigint CHECK (Amount > 0)
)
INSERT INTO PhoneExpenses VALUES (12, 1234567,  22)
INSERT INTO PhoneExpenses VALUES (15, 123456,  5)
SELECT * FROM PhoneExpenses
GO

-- chỉnh sửa
ALTER TABLE ContactPhone
    ALTER COLUMN ServiceProvider varchar(45)

SELECT * FROM ContactPhone
GO


ALTER TABLE ContactPhone
    DROP COLUMN ServiceProvider

SELECT * FROM ContactPhone
GO


-- thêm, xóa ràng buộc 
ALTER TABLE ContactPhone
    ADD CONSTRAINT  CHK_RC CHECK (RentalCHarges > 0)

SELECT * FROM ContactPhone
GO

ALTER TABLE ContactPhone
    DROP CONSTRAINT  CHK_RC 

SELECT * FROM ContactPhone
GO


