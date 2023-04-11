--Câu 1--
CREATE PROC NhapLieuHangSX(@mahangsx nvarchar(10), @tenhang nvarchar(20), @diachi nvarchar(20), @sodt nvarchar(10), @email nvarchar(20))
AS 
IF @tenhang NOT IN (SELECT Tenhang FROM Hangsx)
BEGIN
INSERT INTO Hangsx(mahangsx, Tenhang, Diachi, Sodt, email)
VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email)
END
ELSE 
BEGIN
RAISERROR (N'Tên hãng này đã tồn tại',16,1)
ROLLBACK TRAN
END
GO
dbo.NhapLieuHangSX '001', 'dienthoaixin', 'sg', '012345678', 'email1'
GO

--Câu 2--
CREATE PROC NhapLieuSPmoi(@masp nvarchar(10), @tenhangsx nvarchar(20), @tensp nvarchar(20), @soluong int, @mausac nvarchar(10), @giaban money, @donvitinh nvarchar(10), @mota nvarchar(10))
AS
IF @masp IN (SELECT Masp FROM Sanpham)
BEGIN 
UPDATE Sanpham SET tensp = @tensp, mahangsx = @tenhangsx, soluong = @soluong, mausac = @mausac, giaban = @giaban, donvitinh = @donvitinh, mota = @mota
WHERE masp = @masp
END
ELSE 
BEGIN 
INSERT INTO Sanpham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
VALUES (@masp, @tenhangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
END
GO
dbo.NhapLieuSPmoi 'sanpham1', '001', 'dienthoaipro', '1', 'xanh', '2000000', 'cai', 'vippro'
GO

--Câu 3--
CREATE PROC XoaHang (@Tenhang nvarchar(20))
AS
IF @Tenhang IN (SELECT tenhang FROM Hangsx)
BEGIN
DELETE FROM Hangsx 
WHERE Tenhang = @Tenhang
END
ELSE
BEGIN
RAISERROR (N'Hãng này không tồn tại', 16,1)
ROLLBACK TRAN
END
GO
dbo.XoaHang 'dienthoaipro'

--Câu 4	--
CREATE PROC ChinhsuaNV(@manv nvarchar(10), @tennv nvarchar(20), @gioitinh nvarchar(10), @diachi nvarchar(20), @sodt nvarchar(10), @email nvarchar(20), @phong nvarchar(30), @Flag int)
AS
IF @Flag = 0
BEGIN
UPDATE Nhanvien SET Tennv = @tennv, Gioitinh = @gioitinh, Diachi = @diachi, Sodt = @sodt, email = @email, Phong = @phong
WHERE manv = @manv
END
ELSE 
BEGIN
INSERT INTO Nhanvien(manv, Tennv, Gioitinh, Diachi, Sodt, email, Phong)
VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)
END
GO
dbo.ChinhsuaNV 'nhanvien1', 'Phan Thành Nhân', 'Nam', 'Tân Bình', '0123456789', 'nhanvipprp@gmail.com', 'CNTT', 0
GO

--Câu 5--
CREATE PROC Nhaphang(@shdn nvarchar(10), @masp nvarchar(10), @manv nvarchar (10), @ngaynhap date, @soluongN int, @dongiaN money)
AS
IF @masp IN (SELECT masp FROM Sanpham) AND @manv IN (SELECT Manv FROM Nhanvien)
BEGIN
IF @shdn IN (SELECT Sohdn FROM Nhap)
BEGIN
UPDATE Nhap SET masp = @masp, manv = @manv, Ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN
WHERE Sohdn = @shdn
END
ELSE
BEGIN
INSERT INTO Nhap(Sohdn, masp, manv, Ngaynhap, soluongN, dongiaN)
VALUES (@shdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
END
END
ELSE
BEGIN
RAISERROR (N'masp và manv này không tồn tại',16,1)
ROLLBACK TRAN
	END
GO
dbo.Nhaphang '001', 'sanpham1', 'nhanvien1','2023/04/10', 14, 8000000.0000
GO
