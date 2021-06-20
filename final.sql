-- set SQL_SAFE_UPDATES = 0;
-- drop SCHEMA IF EXISTS btl;
create schema btl;
use	btl;
#------------------- [CUONG]---------------------#
CREATE TABLE GL(
     _no INT AUTO_INCREMENT PRIMARY KEY);
     
CREATE TABLE CD(
     _no INT AUTO_INCREMENT PRIMARY KEY);
     
CREATE TABLE GIAOLO(
     _Ma_giao_lo VARCHAR(8)		PRIMARY KEY,
     _long 		DECIMAL(10,7)		NOT NULL,
     _lat 		DECIMAL(10,7)		NOT NULL);
   
CREATE TABLE CONDUONG(
    _Ma_con_duong	varchar(8)		PRIMARY KEY,
    _Ten_duong		varchar(100)	UNIQUE		NOT NULL);

CREATE TABLE DOANDUONG(
	_Ma_giao_lo_1	varchar(8) NOT NULL,
    _Ma_giao_lo_2	varchar(8) NOT NULL,
    _Ma_con_duong 	varchar(8),
    _STT 			int		UNSIGNED	NOT NULL,
    _Chieu_dai		int 	UNSIGNED	NOT NULL,
    PRIMARY KEY(_Ma_giao_lo_1, _Ma_giao_lo_2) );
   
CREATE TABLE GA_TRAM(
    _Ma_ga_tram 	char(7)			PRIMARY KEY,
    _Dia_chi		varchar(100)	NOT NULL,
    _Ten			varchar(100)	UNIQUE		NOT NULL,
    _Ga_tram		bool			NOT NULL,
    _Ma_giao_lo_1	varchar(8) 	NOT NULL,
    _Ma_giao_lo_2	varchar(8) 	NOT NULL,
    constraint _name
		check (  _Ma_ga_tram like "_______"),
    constraint _name1
		check ( substr(_Ma_ga_tram,1,1) = 'T' OR substr(_Ma_ga_tram,1,1) = 'B' ),
	constraint _name2
        check ( substr(_Ma_ga_tram,2,1) = 'T'),
	constraint _name3
        check ( cast(substr(_Ma_ga_tram,3,5) as signed) >= 0 AND cast(substr(_Ma_ga_tram,3,5) as signed) <=99999));
#------------------------------------------------#

#--------------------------- [TOAN] -------------------------#
CREATE TABLE TUYENTAU_XE (
	ma_tuyen	CHAR(4)		PRIMARY KEY,
    CONSTRAINT 	_checktuyentau_xe
		CHECK 	(ma_tuyen like '____'),
	 CONSTRAINT 	_checktuyentau_xe2
		CHECK	(SUBSTRING(ma_tuyen,1,1) = 'B' or SUBSTRING(ma_tuyen,1,1) = 'T'),
	CONSTRAINT 	_checktuyentau_xe3
		CHECK	(CAST(SUBSTRING(ma_tuyen,2,3) as SIGNED) >= 0 and CAST(SUBSTRING(ma_tuyen,2,3) as SIGNED) <= 999)
);

CREATE TABLE TUYENXEBUS (
    _no INT AUTO_INCREMENT PRIMARY KEY,
    ma_tuyen_tau_xe CHAR(4)		NOT NULL,
    CONSTRAINT _b
		CHECK(SUBSTRING(ma_tuyen_tau_xe,1,1) = 'B')
);

CREATE TABLE TUYENTAUDIEN (
	ma_tuyen_tau 		CHAR 	PRIMARY KEY,
    ten_tuyen_tau 		VARCHAR(100) 	UNIQUE NOT NULL,
	don_gia			DECIMAL(10,3),
	ma_tuyen_tau_xe 	CHAR(4)		NOT NULL,
    CONSTRAINT _t
		CHECK(SUBSTRING(ma_tuyen_tau_xe,1,1) = 'T'),
	CONSTRAINT uppercase
		CHECK (ma_tuyen_tau = UPPER(ma_tuyen_tau))
);

CREATE TABLE CHUYENTAUXE (
	ma_tuyen 			CHAR(4),
    stt 				INT 			UNSIGNED,
    PRIMARY KEY (ma_tuyen, stt)
);
#------------------------------------------------------------#

#--------------------------- [NA] -------------------------#
CREATE TABLE VE
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Loai_ve INT NOT NULL,
    Gia_ve DECIMAL(10,3),
    Ngay_gio_mua DATETIME NOT NULL,
    Ma_hanh_khach  CHAR(8),
    CONSTRAINT check_ve
		CHECK	(SUBSTRING(Ma_ve,1,1) = 'V'),
		CHECK	(SUBSTRING(Ma_ve,2,1) = 'O' or SUBSTRING(Ma_ve,2,1) = 'M' or SUBSTRING(Ma_ve,2,1) = 'D'),
        CONSTRAINT check_ve1
		CHECK	(STR_TO_DATE(SUBSTRING(Ma_ve,3,8),'%d%m%Y') IS NOT NULL),
        CONSTRAINT check_ve2
        CHECK	(CAST(SUBSTRING(Ma_ve,11,1) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_ve,11,1) as SIGNED) <= 9),
        CHECK	(CAST(SUBSTRING(Ma_ve,12,1) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_ve,12,1) as SIGNED) <= 9),
        CHECK	(CAST(SUBSTRING(Ma_ve,13,1) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_ve,13,1) as SIGNED) <= 9),
        CHECK	(CAST(SUBSTRING(Ma_ve,14,1) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_ve,14,1) as SIGNED) <= 9),
        CHECK	(CAST(SUBSTRING(Ma_ve,15,1) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_ve,15,1) as SIGNED) <= 9),
		CHECK( Loai_ve >= 0 and Loai_ve <= 2)
);

CREATE TABLE VE_LE
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Ma_tuyen  CHAR(4) NOT NULL, 
    Ngay_su_dung DATE,
    Ma_ga_tram_len  CHAR(7) NOT NULL,
    Gio_len  TIME,
    Ma_ga_tram_xuong  CHAR(7) NOT NULL,
    Gio_xuong TIME,
    CONSTRAINT _ma_ve
		CHECK(SUBSTRING(Ma_ve,1,2) = 'VO'),
	CONSTRAINT _gio
		CHECK(Gio_xuong > Gio_len)
);

CREATE TABLE VE_THANG
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Ma_tuyen  CHAR(4) NOT NULL,
    Ma_ga_tram_1 CHAR(7) NOT NULL,
    Ma_ga_tram_2  CHAR(7) NOT NULL,
    CONSTRAINT _ma_ve_thang
		CHECK(SUBSTRING(Ma_ve,1,2) = 'VM')
);

CREATE TABLE VE_1_NGAY
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Ngay_su_dung DATE,
    CONSTRAINT _ma_ve_1_ngay
		CHECK(SUBSTRING(Ma_ve,1,2) = 'VD')
);
#----------------------------------------------------------#

#--------------------- [LUN] ------------------#
#------------------------HOAT DONG VE THANG--------------------------------------------------------
create table HOAT_DONG_VE_THANG(
	Ma_ve CHAR(15),
	Ngay_su_dung DATE,
	Gio_len TIME,
	Gio_xuong TIME,
	Ga_tram_len CHAR(7) NOT NULL,
	Ga_tram_xuong CHAR(7) NOT NULL,
	PRIMARY KEY(Ma_ve,Ngay_su_dung,Gio_len),
	CONSTRAINT DK12_Gio_xuong_Gio_len
		CHECK(Gio_xuong > Gio_len),
	CONSTRAINT fk12_Ma_ve
		FOREIGN KEY (Ma_ve) REFERENCES Ve_thang(Ma_ve),
	CONSTRAINT fk12_Ga_tram_len
		FOREIGN KEY (Ga_tram_len) REFERENCES Ga_tram(_Ma_ga_tram),
	CONSTRAINT fk12_Ga_tram_xuong
		FOREIGN KEY (Ga_tram_xuong) REFERENCES Ga_tram(_Ma_ga_tram)
);
#-------------------------HOAT DONG VE 1 NGAY-------------------------------------------------------
create table hoat_dong_ve_1_ngay(
	Ma_ve CHAR(15),
	STT INT,
	Ma_tuyen CHAR(4) NOT NULL,
	Ga_tram_len CHAR(7),
	Ga_tram_xuong CHAR(7),
	Gio_len TIME,
	Gio_xuong TIME,
	PRIMARY KEY(Ma_ve,STT),
	CONSTRAINT DK14_Gio_xuong_Gio_len
		CHECK(Gio_xuong > Gio_len),
	CONSTRAINT fk14_Ma_ve
		FOREIGN KEY (Ma_ve) REFERENCES Ve_1_ngay(Ma_ve),
	CONSTRAINT fk14_Ma_tuyen
		FOREIGN KEY (Ma_tuyen) REFERENCES tuyentau_xe(ma_tuyen),
	CONSTRAINT fk14_Ga_tram_len
		FOREIGN KEY (Ga_tram_len) REFERENCES Ga_tram(_Ma_ga_tram),
	CONSTRAINT fk14_Ga_tram_xuong
		FOREIGN KEY (Ga_tram_xuong) REFERENCES Ga_tram(_Ma_ga_tram)
);
#--------------------------------------------------------------------------------

#--------------------------------HANH KHACH------------------------------------------------
create table Hanh_khach(
	Ma_hanh_khach CHAR(8) primary key check(Ma_hanh_khach like "KH______"),
	CMND VARCHAR(9) not null unique,
	Nghe_nghiep char(30),
	So_dien_thoai VARCHAR(10) unique,
	Gioi_tinh char,
	Email varchar(100),
	Ngay_sinh date,
    CONSTRAINT _ma_hanh_khach
		CHECK	(CAST(SUBSTRING(Ma_hanh_khach,3,6) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_hanh_khach,3,6) as SIGNED) <= 999999)
);
#----------------------------THE TU----------------------------------------------------
create table the_tu(
	Ma_the_tu VARCHAR(8) primary key check(Ma_the_tu like "TT______"),
	Ngay_mua datetime NOT NULL,
	Ma_hanh_khach VARCHAR(8) NOT NULL,
    CONSTRAINT _ma_the_tu
		CHECK	(CAST(SUBSTRING(Ma_the_tu,3,6) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_the_tu,3,6) as SIGNED) <= 999999),
	constraint fk17_Ma_hanh_khach
		foreign key (Ma_hanh_khach) references Hanh_khach(Ma_hanh_khach)
);
#---------------------------BANG VE-----------------------------------------------------
CREATE TABLE Bang_gia (
     ID VARCHAR(10) PRIMARY KEY,
     bus DECIMAL(10 , 3 ),
     ve_1_ngay DECIMAL(10 , 3 ),
     cuoi_tuan DECIMAL(10 , 3 )
);
#----------------------------------------------#

#----------------------------- [PHONG] ---------------------------#
CREATE TABLE gheGa_Tram (
    Ma_tuyen CHAR(4),
    stt INT UNSIGNED,
    MaGT CHAR(7),
    STT_dung INT UNSIGNED NOT NULL,
    Gio_ghe TIME NOT NULL,
	Gio_di TIME NOT NULL,
    PRIMARY KEY (Ma_tuyen , stt , MaGT),
    CHECK (Gio_ghe < Gio_di)
);
    
CREATE TABLE NV (
    MaNV CHAR(6) PRIMARY KEY,
    worktype VARCHAR(20) NOT NULL,
    Bday DATE NOT NULL,
    email CHAR(100),
    sex CHAR,
    mobile_phone INT,
    intern_phone INT,
    CONSTRAINT _maNV
		CHECK 	(MaNV like 'NV____'),
		CHECK	(CAST(SUBSTRING(MaNV,3,4) as SIGNED) >= 0 and CAST(SUBSTRING(MaNV,3,4) as SIGNED) <= 9999)
);

CREATE TABLE Ga_TramLV (
    MaNV CHAR(6) PRIMARY KEY,
    MaGT CHAR(7)
);
#-----------------------------------------------------------------#

#------------------------------- [FOREIGN KEY] -------------------------------#
#----------------- [CUONG] --------------#
ALTER TABLE DOANDUONG
	ADD 	CONSTRAINT _fkey_doanduong1	FOREIGN KEY DOANDUONG (_Ma_giao_lo_1) REFERENCES GIAOLO (_Ma_giao_lo);
ALTER TABLE DOANDUONG
	ADD 	CONSTRAINT _fkey_doanduong2	FOREIGN KEY DOANDUONG (_Ma_giao_lo_2) REFERENCES GIAOLO (_Ma_giao_lo);    
ALTER TABLE DOANDUONG
	ADD 	CONSTRAINT _fkey_doanduong3	FOREIGN KEY DOANDUONG (_Ma_con_duong) REFERENCES CONDUONG (_Ma_con_duong);
ALTER TABLE GA_TRAM
	ADD 	CONSTRAINT _fkey_gatram1	FOREIGN KEY GA_TRAM (_Ma_giao_lo_1) REFERENCES DOANDUONG (_Ma_giao_lo_1);
ALTER TABLE GA_TRAM
	ADD 	CONSTRAINT _fkey_gatram2	FOREIGN KEY GA_TRAM (_Ma_giao_lo_2) REFERENCES DOANDUONG (_Ma_giao_lo_2);
#----------------------------------------#

#----------------------- [TOAN] -----------------------#
ALTER TABLE TUYENXEBUS
	ADD CONSTRAINT fkey_1 
		FOREIGN KEY TUYENXEBUS (ma_tuyen_tau_xe) REFERENCES TUYENTAU_XE (ma_tuyen);
        
ALTER TABLE TUYENTAUDIEN
	ADD CONSTRAINT fkey_2
		FOREIGN KEY TUYENTAUDIEN (ma_tuyen_tau_xe) REFERENCES TUYENTAU_XE (ma_tuyen);
        
ALTER TABLE CHUYENTAUXE
	ADD CONSTRAINT fkey_3
		FOREIGN KEY CHUYENTAUXE (ma_tuyen) REFERENCES TUYENTAU_XE (ma_tuyen);
#------------------------------------------------------#

#-------------------- [NA] ----------------------#
ALTER TABLE VE
	ADD CONSTRAINT _fkey_ve FOREIGN KEY VE(Ma_hanh_khach) REFERENCES HANH_KHACH(Ma_hanh_khach);
    
ALTER TABLE VE_LE
	ADD CONSTRAINT _fkey_ve_le_1 FOREIGN KEY VE_LE(Ma_ve) REFERENCES VE(Ma_ve);
ALTER TABLE VE_LE
	ADD CONSTRAINT _fkey_ve_le_2 FOREIGN KEY VE_LE(Ma_tuyen) REFERENCES TUYENTAU_XE(Ma_tuyen);
ALTER TABLE VE_LE
	ADD CONSTRAINT _fkey_ve_le_3 FOREIGN KEY VE_LE(Ma_ga_tram_len) REFERENCES GA_TRAM(_Ma_ga_tram);
ALTER TABLE VE_LE
	ADD CONSTRAINT _fkey_ve_le_4 FOREIGN KEY VE_LE(Ma_ga_tram_xuong) REFERENCES GA_TRAM(_Ma_ga_tram);

ALTER TABLE VE_THANG
	ADD CONSTRAINT _fkey_ve_thang_1 FOREIGN KEY VE_THANG(Ma_ve) REFERENCES VE(Ma_ve);
ALTER TABLE VE_THANG
	ADD CONSTRAINT _fkey_ve_thang_2 FOREIGN KEY VE_THANG(Ma_tuyen) REFERENCES TUYENTAU_XE(Ma_Tuyen);
ALTER TABLE VE_THANG
	ADD CONSTRAINT _fkey_ve_thang_3 FOREIGN KEY VE_THANG(Ma_ga_tram_1) REFERENCES GA_TRAM(_Ma_ga_tram);
ALTER TABLE VE_THANG
	ADD CONSTRAINT _fkey_ve_thang_4 FOREIGN KEY VE_THANG(Ma_ga_tram_2) REFERENCES GA_TRAM(_Ma_ga_tram);

ALTER TABLE VE_1_NGAY
	ADD CONSTRAINT _fkey_ve_1_ngay FOREIGN KEY VE_1_NGAY(Ma_ve) REFERENCES VE(Ma_VE);
#------------------------------------------------#

#---------------- [LUN] -----------------#
#----------------------------------------#

#-------------------- [PHONG] --------------------#
ALTER TABLE gheGa_Tram
	ADD CONSTRAINT _gheGa_tram1 FOREIGN KEY gheGa_Tram(Ma_tuyen,stt) REFERENCES CHUYENTAUXE(ma_tuyen,stt);
ALTER TABLE gheGa_Tram
	ADD CONSTRAINT _gheGa_tram2 FOREIGN KEY gheGa_Tram(MaGT) REFERENCES GA_TRAM(_Ma_ga_tram);
    
ALTER TABLE Ga_TramLV
	ADD CONSTRAINT _fkey1 FOREIGN KEY (MaNV) REFERENCES NV(MaNV);
ALTER TABLE Ga_TramLV
	ADD CONSTRAINT _fkey2 FOREIGN KEY (MaGT) REFERENCES GA_TRAM(_Ma_ga_tram);
#-------------------------------------------------#
#-----------------------------------------------------------------------------#

#------------------------------------------ [TRIGGER] ----------------------------------------#
#--------------- [CUONG] ---------------#
DELIMITER $$
CREATE TRIGGER before_GIAOLO_insert
BEFORE INSERT
ON GIAOLO FOR EACH ROW
BEGIN
	declare maxi int;
	insert into GL value (NULL);
	select max(_no) from GL into maxi;
	SET NEW._Ma_giao_lo = CONCAT("GL",maxi);
END $$
DELIMITER ;

#------------------------------

DELIMITER $$
CREATE TRIGGER before_CONDUONG_insert
BEFORE INSERT
ON CONDUONG FOR EACH ROW
BEGIN
	declare maxi int;
	insert into CD value (NULL);
	select max(_no) from CD into maxi;
	SET NEW._Ma_con_duong = CONCAT("CD",maxi);
END $$
DELIMITER ;
#---------------------------------------#

#----------------------------[TOAN]-----------------------#
DELIMITER $$
CREATE TRIGGER check_don_gia_tau_dien
BEFORE INSERT
ON tuyentaudien FOR EACH ROW
BEGIN
	DECLARE don_gia_bus DECIMAL(10, 3);
    
	DECLARE cntDonGiaBus INT;
    SELECT Count(*) FROM Bang_gia INTO cntDonGiaBus;
    
    IF cntDonGiaBus = 1 THEN 
		SET don_gia_bus = (SELECT bus FROM Bang_gia);
		IF NEW.don_gia <= don_gia_bus THEN 
			signal sqlstate '45000' set message_text = 'Khong the insert duoc vi don gia tau dien phai lon hon don gia bus';
		END IF;
	END IF;
END $$
DELIMITER ;
#-----------------------------------------------------------#

#---------------------- [LUNA] ------------------#
#-------------------------TRIGGER1-----------------------------------------------
DELIMITER $$
CREATE TRIGGER check_ga_tram_len_xuong
BEFORE INSERT
ON Hoat_dong_ve_thang FOR EACH ROW
	BEGIN
    DECLARE Gatram1 CHAR(7);
    DECLARE Gatram2 CHAR(7);
    
    SELECT Ma_ga_tram_1  INTO Gatram1 FROM Ve_thang WHERE Ma_ve=NEW.Ma_ve;
    SELECT Ma_ga_tram_2  INTO Gatram2 FROM Ve_thang WHERE Ma_ve=NEW.Ma_ve;
     
    IF !((Gatram1 = NEW.Ga_tram_len AND Gatram2 = NEW.Ga_tram_xuong) OR (Gatram2 = NEW.Ga_tram_len AND Gatram1 = NEW.Ga_tram_xuong))
    THEN signal sqlstate '45000' set message_text = 'Khong the insert duoc vi ma ga tram khong trung khop';
    END IF;
    END $$
DELIMITER ;


#-----------------------TRIGGER 2------------------------------------------------
DELIMITER $$
CREATE TRIGGER cap_nhat_gia_ve_le
BEFORE INSERT ON Ve_le 
FOR EACH ROW
BEGIN
	DECLARE STT1 INT;
    DECLARE STT2 INT;
    DECLARE Gia_ve_le DECIMAL(10,3) DEFAULT 0;
    DECLARE Don_gia_ve DECIMAL(10,3) DEFAULT 0;
    
	SELECT STT_dung FROM gheGa_Tram WHERE MaGT = NEW.Ma_ga_tram_len AND Ma_tuyen = NEW.Ma_tuyen LIMIT 1 INTO STT1;
    SELECT STT_dung FROM gheGa_Tram WHERE MaGT = NEW.Ma_ga_tram_xuong AND Ma_tuyen = NEW.Ma_tuyen LIMIT 1 INTO STT2;
    
    IF NEW.Ma_tuyen like "T___" THEN 
    SELECT don_gia FROM tuyentaudien WHERE ma_tuyen_tau_xe = NEW.Ma_tuyen INTO Don_gia_ve;
    ELSE 
    SELECT bus FROM Bang_gia WHERE ID ="giave" INTO Don_gia_ve;
    END IF;
    SET Gia_ve_le = Don_gia_ve*((STT2-STT1+1) + (STT2-STT1+1)%2)/2;
    UPDATE VE
    SET Gia_ve= Gia_ve_le WHERE Ma_ve = NEW.Ma_ve;
END $$
DELIMITER ;
----------------------------------
DELIMITER $$
CREATE TRIGGER cap_nhat_gia_ve_1_ngay
BEFORE INSERT ON Ve_1_ngay
FOR EACH ROW
BEGIN
	DECLARE Gia_ve_1_ngay DECIMAL(10,3) DEFAULT 0;
    DECLARE Gia_cuoi_tuan DECIMAL(10,3) DEFAULT 0;
    
    SELECT ve_1_ngay FROM bang_gia WHERE ID="giave" INTO Gia_ve_1_ngay;
    SELECT cuoi_tuan FROM bang_gia WHERE ID="giave" INTO Gia_cuoi_tuan;
    
    UPDATE VE
    SET Gia_ve=Gia_ve_1_ngay WHERE Ma_ve = NEW.Ma_ve
    AND DAYNAME(STR_TO_DATE(substring(Ma_ve,3,8),'%d%m%Y')) != 'Saturday' 
    AND DAYNAME(STR_TO_DATE(substring(Ma_ve,3,8),'%d%m%Y')) != 'Sunday';
    
    UPDATE VE
    SET Gia_ve=Gia_cuoi_tuan WHERE Ma_ve = NEW.Ma_ve
    AND (DAYNAME(STR_TO_DATE(substring(Ma_ve,3,8),'%d%m%Y')) = 'Saturday' 
    OR DAYNAME(STR_TO_DATE(substring(Ma_ve,3,8),'%d%m%Y')) = 'Sunday');
END $$
DELIMITER ;

----------------------------------------------------
DELIMITER $$
CREATE TRIGGER cap_nhat_gia_ve_thang
BEFORE INSERT ON Ve_thang
FOR EACH ROW
BEGIN
	DECLARE STT1 INT;
    DECLARE STT2 INT;
    DECLARE Gia_ve_le DECIMAL(10,3) DEFAULT 0;
    DECLARE Don_gia_ve DECIMAL(10,3) DEFAULT 0;
    DECLARE Gia_ve_thang DECIMAL(10,3) DEFAULT 0;
    DECLARE Nghe_nghiep CHAR(30);
    
	SELECT STT_dung FROM gheGa_Tram WHERE MaGT = NEW.Ma_ga_tram_1 AND Ma_tuyen=NEW.Ma_tuyen LIMIT 1 INTO STT1;
    SELECT STT_dung FROM gheGa_Tram WHERE MaGT = NEW.Ma_ga_tram_2 AND Ma_tuyen=NEW.Ma_tuyen LIMIT 1 INTO STT2;
    SELECT Hanh_khach.Nghe_nghiep FROM Hanh_khach,Ve WHERE NEW.Ma_ve=Ve.Ma_ve AND Ve.Ma_hanh_khach=Hanh_khach.Ma_hanh_khach INTO Nghe_nghiep;
    
    IF NEW.Ma_tuyen like "T___" THEN 
		SELECT don_gia FROM tuyentaudien WHERE ma_tuyen_tau_xe = NEW.Ma_tuyen INTO Don_gia_ve;
    ELSE 
		SELECT bus FROM Bang_gia WHERE ID ="giave" INTO Don_gia_ve;
    END IF;
    
    SET Gia_ve_le = Don_gia_ve*((STT2-STT1+1) + (STT2-STT1+1)%2)/2;
    SET Gia_ve_thang =Gia_ve_le*40;
    
    IF Nghe_nghiep ="Sinh vien" OR Nghe_nghiep="Hoc sinh" THEN
		SET Gia_ve_thang = Gia_ve_thang/2;
    ELSEIF STR_TO_DATE(substring(NEW.Ma_ve,3,8),'%d%m%Y')>curdate() THEN
		SET Gia_ve_thang = Gia_ve_thang*0.9;
    END IF;
    UPDATE VE
		SET Gia_ve= Gia_ve_thang WHERE Ma_ve = NEW.Ma_ve;
END $$
DELIMITER ;
----------------------------------------------------
DELIMITER $$
CREATE TRIGGER them_gia_ve
BEFORE INSERT ON Bang_gia
FOR EACH ROW
BEGIN
	DECLARE N INT;
    SELECT COUNT(*) FROM Bang_gia INTO N;
    IF N=1 THEN signal sqlstate '45000' set message_text = 'Da co gia ve roi ban nen update';
    END IF;
    
    SELECT COUNT(*) FROM TUYENTAUDIEN INTO N;
    IF N <> 0 AND NEW.bus >= (SELECT min(don_gia) FROM TUYENTAUDIEN) THEN
		signal sqlstate '45000' set message_text = 'Khong the insert duoc vi don gia bus phai nho hon don gia tau dien';
	END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER cap_nhat_gia_ve
BEFORE UPDATE ON Bang_gia
FOR EACH ROW
BEGIN
	IF NEW.bus >= (SELECT min(don_gia) FROM TUYENTAUDIEN)
    THEN signal sqlstate '45000' set message_text = 'Khong the update duoc vi don gia bus phai nho hon don gia tau dien';
    END IF;
END $$
DELIMITER ;
#------------------------------------------------#
#---------------------------------------------------------------------------------------------#

#-------------------------------------- [PROCEDURE] ----------------------------------#
-- 1 --
DELIMITER $$
CREATE PROCEDURE LoTrinhTuyenXeTau(IN ma_tuyen CHAR(4))
BEGIN
		SELECT GROUP_CONCAT(CONCAT(' ', CONCAT("Trạm " ,gt._Ten), '') order by ch.STT_dung ) AS LoTrinh
		FROM ghega_tram ch, GA_TRAM gt
		WHERE gt._Ma_ga_tram = ch.MaGT AND ch.Ma_tuyen = ma_tuyen AND ch.stt = 1
		ORDER BY ch.STT_dung;
END; $$
DELIMITER ;

-- 2 --
DELIMITER $$
CREATE PROCEDURE ThongKeLuotNguoi (
	IN matuyen CHAR(4), 
	IN fromDate CHAR(10), 
	IN toDate CHAR(10)
)
BEGIN
		DECLARE numberofDays 		INT;
    	DECLARE i 			INT DEFAULT 0;
        DECLARE Fdate		DATE;
        DECLARE Tdate		DATE;
    	DECLARE Tong1 			INT DEFAULT 0;
		DECLARE Tong2 			INT DEFAULT 0;
    	DECLARE Tong3 			INT DEFAULT 0;
	
        SET Fdate = STR_TO_DATE(fromDate,'%d/%m/%Y');
		SET Tdate = STR_TO_DATE(toDate,'%d/%m/%Y');
		
    	CREATE TABLE Bang (
		Ngay	CHAR(10) 	PRIMARY KEY,
		TongSoLuotNguoi	INT);
    
    	SET numberofDays = DATEDIFF(TDate, FDate);
        
	WHILE (i<=numberofDays) DO
		SELECT COUNT(*) AS Tong1 INTO Tong1 
		FROM VE_LE vl
        	WHERE vl.Ngay_su_dung = DATE_ADD(FDate, INTERVAL i DAY) AND vl.Ma_tuyen = matuyen;   
		
		SELECT COUNT(*) AS Tong2 INTO Tong2 
		FROM VE_THANG vt, HOAT_DONG_VE_THANG hdvt
        	WHERE vt.Ma_ve = hdvt.Ma_ve AND hdvt.Ngay_su_dung = DATE_ADD(FDate, INTERVAL i DAY) AND vt.Ma_tuyen = matuyen;  
		
		SELECT COUNT(*) AS Tong3 INTO Tong3 
		FROM VE_1_NGAY vn, hoat_dong_ve_1_ngay hdvn
       		WHERE vn.Ma_ve = hdvn.Ma_ve AND vn.Ngay_su_dung = DATE_ADD(FDate, INTERVAL i DAY) AND hdvn.Ma_tuyen = matuyen;
            
		insert into Bang values (DATE_FORMAT(DATE_ADD(FDate, INTERVAL i DAY), '%d/%m/%Y'),Tong1+Tong2+Tong3);
		SET i=i+1;
	END WHILE;
    
     	SELECT *
        From Bang
		ORDER BY STR_TO_DATE(Ngay,'%d/%m/%Y');
		drop table Bang;
END; $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ThongTinHanhKhach()
BEGIN
	SELECT * FROM Hanh_khach;
END; $$
DELIMITER ;

#CALL ThongKeLuotNguoi("T001","02/03/2021","20/05/2021");
#-------------------------------------------------------------------------------------#
DELIMITER $$
CREATE PROCEDURE ThemTauXeGheGaTram(
	In Ma_tuyen CHAR(4),
    In stt INT UNSIGNED,
    In MaGT CHAR(7),
    In STT_dung INT UNSIGNED,
    In Gio_ghe TIME , In Gio_di TIME 
) 
BEGIN
	IF NOT EXISTS (SELECT * FROM GA_TRAM WHERE _Ma_ga_tram = MaGT) THEN
		signal sqlstate '45000' set message_text = 'Khong ton tai ma ga tram';
	END IF;
    IF Gio_ghe >= Gio_di THEN
		signal sqlstate '45000' set message_text = 'Gio ghe phai nho hon gio di';
	END IF;
    insert into chuyentauxe values(Ma_tuyen, stt);
	insert into gheGa_Tram values(Ma_tuyen, stt, MaGT, STT_dung, Gio_ghe, Gio_di);
END; $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ThemTuyenXe(IN ma_tuyen CHAR(4))
BEGIN
	insert into TUYENTAU_XE values(ma_tuyen);
    insert into TUYENXEBUS values(null, ma_tuyen);
END; $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ThemTuyenTau( IN ma_tuyen_tau CHAR, IN ten_tuyen_tau VARCHAR(100), IN don_gia DECIMAL(10,3), IN ma_tuyen CHAR(4))
BEGIN
	DECLARE don_gia_bus DECIMAL(10, 3);
	DECLARE cntDonGiaBus INT;
    
	IF ma_tuyen_tau <> UPPER(ma_tuyen_tau) THEN
		signal sqlstate '45000' set message_text = 'Ma tuyen tau phai la mot chu in hoa';
	END IF;
	
    SELECT Count(*) FROM Bang_gia INTO cntDonGiaBus;
    
    IF cntDonGiaBus = 1 THEN 
		SET don_gia_bus = (SELECT bus FROM Bang_gia);
		IF don_gia <= don_gia_bus THEN 
			signal sqlstate '45000' set message_text = 'Khong the insert duoc vi don gia tau dien phai lon hon don gia bus';
		END IF;
	END IF;
    
	insert into TUYENTAU_XE values(ma_tuyen);
    insert into TUYENTAUDIEN values(ma_tuyen_tau, ten_tuyen_tau, don_gia, ma_tuyen);
END; $$
DELIMITER ;

#-------------------------------------------------------------------------------------#

#-------------------------------------------------------- [INSERT] ----------------------------------------------#
insert into GIAOLO (_long, _lat) values(1,1);
insert into GIAOLO (_long, _lat) values(1,2);
insert into GIAOLO (_long, _lat) values(1,3);
insert into GIAOLO (_long, _lat) values(1,4);
insert into GIAOLO (_long, _lat) values(1,5);

#-----------------------------------------

insert into CONDUONG (_Ten_duong)
	values("Hung");
insert into CONDUONG(_Ten_duong)
	values("Cuong");
insert into CONDUONG(_Ten_duong)
	values("Dang");
insert into CONDUONG(_Ten_duong)
	values("Le");
insert into CONDUONG(_Ten_duong)
	values("Dinh");
    
#-----------------------------------------

insert into DOANDUONG
	values("GL1","GL2","CD1",1,1);
insert into DOANDUONG
	values("GL2","GL3","CD2",2,1);
insert into DOANDUONG
	values("GL3","GL4","CD3",3,1);
insert into DOANDUONG
	values("GL4","GL5","CD4",4,1);
insert into DOANDUONG
	values("GL5","GL1","CD5",5,1);
    
#-------------------------------------------

insert into GA_TRAM
	values("BT00001","nha tau1","tau1",FALSE,"GL1","GL2");
insert into GA_TRAM
	values("BT00002","nha tau2","tau2",FALSE,"GL2","GL3");
insert into GA_TRAM
	values("TT00001","nha tau3","tau3",TRUE,"GL3","GL4");
insert into GA_TRAM
	values("TT00002","nha tau4","tau4",TRUE,"GL4","GL5");
insert into GA_TRAM
	values("TT00003","nha tau5","tau5",TRUE,"GL5","GL1");
    
#--------------------------------------------

insert into tuyentau_xe
	values("B001");
insert into tuyentau_xe
	values("B002");
insert into tuyentau_xe
	values("B003");
insert into tuyentau_xe
	values("B004");
insert into tuyentau_xe
	values("B005");
insert into tuyentau_xe
	values("T001");
insert into tuyentau_xe
	values("T002");
insert into tuyentau_xe
	values("T003");
insert into tuyentau_xe
	values("T004");
insert into tuyentau_xe
	values("T005");
    
#---------------------------------------------

insert into tuyenxebus (ma_tuyen_tau_xe)
	values("B001");
insert into tuyenxebus (ma_tuyen_tau_xe)
	values("B002");
 insert into tuyenxebus (ma_tuyen_tau_xe)
	values("B003");   
 insert into tuyenxebus (ma_tuyen_tau_xe)
	values("B004");   
insert into tuyenxebus (ma_tuyen_tau_xe)
	values("B005"); 

#---------------------------------------------

insert into tuyentaudien
	values("A","DANGHUNGCUONG",20.000,"T001");
insert into tuyentaudien
	values("B","TOTHANHPHONG",25.000,"T002");
insert into tuyentaudien
	values("C","VOMINHTOAN",22.000,"T003");
insert into tuyentaudien
	values("D","LEDINHLUAN",24.000,"T004");
insert into tuyentaudien
	values("E","VOTHINA",23.000,"T005");
    
#--------------------------------------------

insert into chuyentauxe
	values("B001",1);
insert into chuyentauxe
	values("B001",2);
insert into chuyentauxe
	values("B002",1);
insert into chuyentauxe
	values("T001",1);
insert into chuyentauxe
	values("T002",1);
insert into chuyentauxe
	values("T002",2);
    
#---------------------

insert into ghega_tram
	values("B001",1,"BT00001",1,"6:10:00","6:20:00" );
insert into ghega_tram
	values("B001",1,"BT00002",2,"6:40:00", "6:50:00");
    
insert into ghega_tram
	values("B001",2,"BT00001",1,"6:40:00","6:50:00" );
insert into ghega_tram
	values("B001",2,"BT00002",2,"7:20:00", "7:30:00");
    
insert into ghega_tram
	values("B002",1,"BT00002",1,"8:00:00","8:10:00" );
insert into ghega_tram
	values("B002",1,"BT00001",2,"9:20:00", "9:30:00");

insert into ghega_tram
	values("T001",1,"TT00001",1,"12:20:00", "12:30:00");
insert into ghega_tram
	values("T001",1,"TT00002",2,"12:50:00", "13:00:00");
insert into ghega_tram
	values("T001",1,"TT00003",3,"13:20:00", "13:30:00");
    
insert into ghega_tram
	values("T002",1,"TT00002",1,"13:20:00", "13:30:00");
insert into ghega_tram
	values("T002",1,"TT00003",2,"13:50:00", "14:00:00");
insert into ghega_tram
	values("T002",1,"TT00001",3,"14:20:00", "14:30:00");
    
insert into ghega_tram
	values("T002",2,"TT00002",1,"14:20:00", "14:30:00");
insert into ghega_tram
	values("T002",2,"TT00003",2,"14:50:00", "15:00:00");
insert into ghega_tram
	values("T002",2,"TT00001",3,"15:20:00", "15:30:00");
    
#------------------------

insert into hanh_khach
	values("KH000001",111111111,"Sinh vien",1111111111,"M","aaaaaaemail","20010101");
insert into hanh_khach
	values("KH000002",222222222,"Sinh vien",2222222222,"M","bbbbbbemail","20000101");
insert into hanh_khach
	values("KH000003",333333333,"Sinh vien",3333333333,"F","ccccccemail","19990101");
insert into hanh_khach
	values("KH000004",444444444,"Sinh vien",4444444444,"F","ddddddemail","19980101");
insert into hanh_khach
	values("KH000005",555555555,"Sinh vien",5555555555,"M","eeeeeeemail","19970101");
#--------------------------------------------------------------------------------

insert into bang_gia values('giave',3.000,10.000,12.000);

#--------------------------------------------------------------------------------

insert into ve
	values("VO0106202111111",0,NULL,"2021-06-01 6:05:06","KH000001");
insert into ve
	values("VO0106202122222",0,NULL,"2021-06-01 7:05:06","KH000002");
insert into ve
	values("VO0106202133333",0,NULL,"2021-06-01 10:22:11","KH000003");
insert into ve
	values("VO0106202144444",0,NULL,"2021-06-01 8:09:10","KH000004");
insert into ve
	values("VO0106202155555",0,NULL,"2021-06-01 12:20:20","KH000005");
    
insert into ve_le
	values("VO0106202111111","B001","2021-06-02","BT00001","06:15:06","BT00002","06:45:07");
insert into ve_le
	values("VO0106202122222","B002","2021-06-03","BT00002","08:07:07","BT00001","09:28:08");
insert into ve_le
	values("VO0106202133333","T001","2021-06-04","TT00001","12:25:08","TT00003","13:25:09");
insert into ve_le
	values("VO0106202144444","T002","2021-06-05","TT00002","13:25:09","TT00001","14:26:10");
insert into ve_le
	values("VO0106202155555","T002","2021-06-06","TT00003","14:56:10","TT00001","15:22:11");
    
#--------------------------------
--
insert into ve
	values("VD0106202111111",2,NULL,"2021-06-01 6:05:06","KH000001");
insert into ve
	values("VD0106202122222",2,NULL,"2021-06-01 7:05:06","KH000001");
insert into ve
	values("VD0106202133333",2,NULL,"2021-06-01 10:22:11","KH000003");
insert into ve
	values("VD0106202144444",2,NULL,"2021-06-01 8:09:10","KH000003");
insert into ve
	values("VD0106202155555",2,NULL,"2021-06-01 20:20:20","KH000005");
    
insert into ve_1_ngay
	values("VD0106202111111","2021-06-02");
insert into ve_1_ngay
	values("VD0106202122222","2021-06-03");
insert into ve_1_ngay
	values("VD0106202133333","2021-06-04");
insert into ve_1_ngay
	values("VD0106202144444","2021-06-05");
insert into ve_1_ngay
	values("VD0106202155555","2021-06-06");
    
#-----------------------------------
insert into Hoat_dong_ve_1_ngay values("VD0106202111111",1,"B001","BT00001","BT00002",'6:15:00','6:45:00');
insert into Hoat_dong_ve_1_ngay values("VD0106202111111",2,"B002","BT00002","BT00001",'8:07:03','9:23:10');
insert into Hoat_dong_ve_1_ngay values("VD0106202111111",3,"T001","TT00001","TT00002",'12:23:00','12:52:02');
insert into Hoat_dong_ve_1_ngay values("VD0106202111111",4,"T002","TT00002","TT00003",'13:23:17','13:53:36');
insert into Hoat_dong_ve_1_ngay values("VD0106202133333",1,"T002","TT00003","TT00001",'14:52:02','15:22:35');
--
insert into ve
	values("VM0106202111111",1,NULL,"2021-06-01 06:05:06","KH000001");
insert into ve
	values("VM0106202100002",1,NULL,"2021-06-01 7:05:06","KH000001");
insert into ve
	values("VM0106202100003",1,NULL,"2021-06-01 10:22:11","KH000003");
insert into ve
	values("VM0106202100004",1,NULL,"2021-06-01 8:09:10","KH000005");
insert into ve
	values("VM0106202100005",1,NULL,"2021-06-01 20:20:20","KH000005");
#-------------------------------
insert into ve_thang
	values("VM0106202111111","B001","BT00001","BT00002");
insert into ve_thang
	values("VM0106202100002","B002","BT00002","BT00001");
insert into ve_thang
	values("VM0106202100003","T001","TT00001","TT00002");
insert into ve_thang
	values("VM0106202100004","T002","TT00002","TT00003");
insert into ve_thang
	values("VM0106202100005","T002","TT00003","TT00001");
#------------------------------
insert into Hoat_dong_ve_thang values ("VM0106202111111",'2021-06-18','6:15:10','6:45:20',"BT00001","BT00002");
insert into Hoat_dong_ve_thang values ("VM0106202111111",'2021-06-19','6:45:00','7:25:00',"BT00001","BT00002");
insert into Hoat_dong_ve_thang values ("VM0106202111111",'2021-06-20','6:13:15','6:47:21',"BT00001","BT00002");
insert into Hoat_dong_ve_thang values ("VM0106202100004",'2021-06-21',"13:22:03","13:52:17","TT00002","TT00003");
insert into Hoat_dong_ve_thang values ("VM0106202100004",'2021-06-22','14:25:52','14:52:25',"TT00002","TT00003");

#-------------------------------
#------------------------------------
insert into the_tu values("TT000001",'2020-05-22','KH000001');
insert into the_tu values("TT000002",'2020-05-23','KH000002');
insert into the_tu values("TT000003",'2020-05-25','KH000003');
insert into the_tu values("TT000004",'2020-06-22','KH000004');
insert into the_tu values("TT000005",'2021-01-12','KH000005');
#-------------------------------------
insert into nv
	values("NV0001","cong nhan","2001-06-07","aaaaaaemail","M",1111111111, NULL);
insert into nv
	values("NV0002","cong nhan","1999-02-26"," bbbbbbemail","M",NULL,NULL);
insert into nv
	values("NV0003","Quan ly","1998-06-09","ccccccemail","F",NULL,NULL);
insert into nv
	values("NV0004","cong nhan","1998-05-26","mmmmmmemail","F",NULL,NULL);
insert into nv
	values("NV0005","cong nhan","1997-05-05","nnnnnnemail","F",1269845711,NULL);
#------------------------------------
insert into ga_tramlv
	values("NV0001","BT00001");
insert into ga_tramlv
	values("NV0002","BT00002");
insert into ga_tramlv
	values("NV0003","TT00001");
insert into ga_tramlv
	values("NV0004","TT00002");
insert into ga_tramlv
	values("NV0005","TT00003");
#-------------------------------------------------- [ADD USER] ---------------------------------------------------#
CREATE USER 'sManager1'@'localhost' IDENTIFIED BY '1';
GRANT SELECT, INSERT, DELETE, UPDATE, EXECUTE ON btl.* TO  'sManager'@'localhost';
#-----------------------------------------------------------------------------------------------------------------#
