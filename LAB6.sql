use QLBanHang
--Câu 1--
CREATE FUNCTION DanhSachSanPhamTheoHangSX (@tenHangSX varchar(50))
RETURNS TABLE
AS
RETURN
    SELECT SanPham.MaSP, SanPham.TenSP, SanPham.SoLuong, SanPham.MauSac, SanPham.GiaBan, SanPham.DonViTinh, SanPham.MoTa, HangSX.TenHang
    FROM SanPham
    INNER JOIN HangSX ON SanPham.MaHangSX = HangSX.MaHangSX
    WHERE HangSX.TenHang = @tenHangSX
SELECT * FROM DanhSachSanPhamTheoHangSX('SamSung')
--Câu 2--
DanhSachSanPhamNhap(@ngayX date, @ngayY date)
RETURNS TABLE
AS
RETURN
    SELECT sp.tensp, hs.tenhang, n.ngaynhap
    FROM Sanpham sp
    JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    JOIN Nhap n ON sp.masp = n.masp
    WHERE n.ngaynhap >= @ngayX AND n.ngaynhap <= @ngayY
GO
SELECT * FROM DanhSachSanPhamNhap('2019-05-02', '2020-07-04')

--Câu 3--
CREATE FUNCTION LuaChon(@luachon INT)
RETURNS @bang TABLE (tensp NVARCHAR(20), masp NVARCHAR(10),tenhang NVARCHAR(20), Soluong INT)
AS
BEGIN
IF @luachon = 0
BEGIN
INSERT INTO @bang 
SELECT tensp, Sanpham.masp, tenhang, Soluong FROM Sanpham INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE soluong < 0
END
IF @luachon = 1
BEGIN
INSERT INTO @bang
SELECT tensp, Sanpham.masp, tenhang, Soluong FROM Sanpham INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE soluong > 0
END
RETURN
END

--câu 4--
CREATE FUNCTION ThongTinNV (@Phong NVARCHAR(30))
RETURNS TABLE RETURN
SELECT Tennv FROM Nhanvien
WHERE Nhanvien.Phong = @Phong
GO
SELECT *FROM ThongTinNV ('Vat tu')

--câu 6--
CREATE FUNCTION DSXuat (@x INT, @y INT)
RETURNS TABLE RETURN
SELECT Tenhang, tensp, soluongX
FROM Xuat INNER JOIN Sanpham ON Xuat.Masp = Sanpham.masp INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.Mahangsx
WHERE YEAR(Ngayxuat) BETWEEN @x AND @y
GO
SELECT * FROM DSXuat(2019, 2020)

--câu 8--
CREATE FUNCTION NVNhap (@x INT)
RETURNS TABLE RETURN
SELECT Nhanvien.Manv, Tennv, Phong
FROM Nhanvien INNER JOIN Nhap ON Nhanvien.Manv = Nhap.Manv
WHERE DAY(Ngaynhap) = @x
GO
SELECT * FROM NVNhap (22)