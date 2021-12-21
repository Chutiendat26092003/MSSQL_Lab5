CREATE DATABASE BookLibrary
GO

USE BookLibrary
GO

-- tạo bảng book 
CREATE TABLE Books (
    BookCode INT CONSTRAINT PK PRIMARY KEY, 
	BookTitle VARCHAR(100) NOT NULL, -- tên sách 
	Author VARCHAR(50) NOT NULL, -- tác giả
	Edition INT, --lần xuất bản 
	BookPrice money, -- giá bán
	Copies INT -- số cuốn có trong thư viện 
)
INSERT INTO Books VALUES (55, N'Đắc nhân tâm', N'Dale Carnegie', 20, 78000, 15)
INSERT INTO Books VALUES (66, N'Cây táo yêu thương', N'Shel Silverstein', 12, 80000, 25)
SELECT * FROM Books 
GO

--bảng lưu thông tin người mượn 
CREATE TABLE Member(
    MemberCode INT CONSTRAINT PK_M PRIMARY KEY,
	MemberName VARCHAR(50) NOT NULL,
	MemberAddress VARCHAR(100) NOT NULL,
	PhoneNumber INT
)
INSERT INTO Member VALUES (5252, N'Nguyễn Văn A', N'Hà Nội', 0923456789)
INSERT INTO Member VALUES (6668, N'Nguyễn Văn B', N'Hà Nội', 0933456789)
SELECT * FROM Member
GO


-- tạo bảng thông tin mượn sách 
CREATE TABLE IssueDetails(
    BookCode INT CONSTRAINT fkr FOREIGN KEY (BookCode) REFERENCES Books(BookCode),
	MemberCode INT CONSTRAINT fk FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode),
	IssueDate datetime,
	ReturnDate datetime
)
INSERT INTO IssueDetails VALUES (55, 5252, NULL, NULL)
SELECT * FROM IssueDetails



-- thêm, xóa ràng buộc
--a
ALTER TABLE IssueDetails
    DROP CONSTRAINT fkr

ALTER TABLE IssueDetails
	DROP CONSTRAINT fk
GO

--b
ALTER TABLE Member 
    DROP CONSTRAINT PK_M

ALTER TABLE Books
    DROP CONSTRAINT PK

--c 
ALTER TABLE Member 
    ADD CONSTRAINT PK_M PRIMARY KEY (MemberCode)

ALTER TABLE Books
    ADD CONSTRAINT PK PRIMARY KEY (BookCode)

--d
ALTER TABLE IssueDetails
    ADD CONSTRAINT fkr_b FOREIGN KEY (BookCode) REFERENCES Books(BookCode)

ALTER TABLE IssueDetails
    ADD CONSTRAINT fk_M FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode)


--e
ALTER TABLE Books
    ADD CONSTRAINT CHK_BP CHECK( BookPrice >1 AND BookPrice < 200)


--f
ALTER TABLE Member
    ADD CONSTRAINT UNI_M UNIQUE(PhoneNumber)

-- g
ALTER TABLE IssueDetails
    ADD CONSTRAINT NN NOT NULL (BookCode) ---

ALTER TABLE IssueDetails
	ADD CONSTRAINT NN NOT NULL(MemberCode); ---


-- h theo em hiểu thì câu này đang bị mâu thuẫn với câu d ạ 
ALTER TABLE IssueDetails 
    ADD CONSTRAINT PK_I_B PRIMARY KEY (BookCode)

ALTER TABLE IssueDetails 
    ADD CONSTRAINT PK_I_M PRIMARY KEY (MemberCode)
