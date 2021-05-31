create schema btl;
use	btl;

#------------------- [CUONG]---------------------#
CREATE TABLE GIAOLO(
     _Ma_giao_lo VARCHAR(8)		PRIMARY KEY,
     _long 		FLOAT(10,7)		NOT NULL,
     _lat 		FLOAT(10,7)		NOT NULL);
   
CREATE TABLE CONDUONG(
    _Ten_duong		varchar(100)	UNIQUE		NOT NULL,
    _Ma_con_duong	varchar(8)		PRIMARY KEY);

CREATE TABLE DOANDUONG(
	_Ma_giao_lo_1	varchar(8),
    _Ma_giao_lo_2	varchar(8),
    _Ma_con_duong 	varchar(16),
    _STT 			int		UNSIGNED	NOT NULL,	
    _Chieu_dai		int 	UNSIGNED	NOT NULL,
    PRIMARY KEY(_Ma_giao_lo_1, _Ma_giao_lo_2) );
   
CREATE TABLE GA_TRAM(
    _Ma_ga_tram 	char(7)			PRIMARY KEY,
    _Dia_chi		varchar(100)	NOT NULL,
    _Ten			varchar(100)	UNIQUE		NOT NULL,
    _Ga_tram		bool			NOT NULL,
    _Ma_giao_lo_1	varchar(8) 	,
    _Ma_giao_lo_2	varchar(8) 	,
    constraint _name
		check (  _Ma_ga_tram like "_______"),
    constraint _name1
		check ( substr(_Ma_ga_tram,1,1) = 'T' OR substr(_Ma_ga_tram,1,1) = 'B' ),
	constraint _name2
        check ( substr(_Ma_ga_tram,2,1) = 'T'),
	constraint _name3
        check ( cast(substr(_Ma_ga_tram,3,5) as signed) >= 0 AND cast(substr(_Ma_ga_tram,3,5) as signed) <=99999));
   
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


DELIMITER $$
CREATE TRIGGER before_GIAOLO_insert
BEFORE INSERT
ON GIAOLO FOR EACH ROW
BEGIN
    DECLARE Tong 	INT;
    DECLARE Tong1 	INT;
	SELECT COUNT(*) AS Tong INTO Tong
	FROM GIAOLO ;
    IF Tong = 0 THEN
	SET NEW._Ma_giao_lo = CONCAT("GL",Tong + 1);
        
    ELSE
	SELECT    cast(substr(_Ma_giao_lo,3,LENGTH(_Ma_giao_lo) - 2) as signed) 
        FROM GIAOLO 
        ORDER BY  cast(substr(_Ma_giao_lo,3,LENGTH(_Ma_giao_lo) - 2) as signed) DESC
        LIMIT 1 
        INTO Tong1;
        
		IF Tong = Tong1 THEN
			SET NEW._Ma_giao_lo = CONCAT("GL",Tong + 1);
		ELSE	
			SET NEW._Ma_giao_lo = CONCAT("GL",Tong1 + 1);
		END IF;
	END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_CONDUONG_insert
BEFORE INSERT
ON CONDUONG FOR EACH ROW
BEGIN
    DECLARE Tong 	INT;
    DECLARE Tong1 	INT;
    SELECT COUNT(*) AS Tong INTO Tong
    FROM CONDUONG ;
    IF Tong = 0 THEN
		SET NEW._Ma_con_duong = CONCAT("CD",Tong + 1);
        
    ELSE
	SELECT    cast(substr(_Ma_con_duong,3,LENGTH(_Ma_con_duong) - 2) as signed) 
        FROM CONDUONG 
        ORDER BY  cast(substr(_Ma_con_duong,3,LENGTH(_Ma_con_duong) - 2) as signed) DESC
        LIMIT 1 
        INTO Tong1;
        
		IF Tong = Tong1 THEN
			SET NEW._Ma_con_duong = CONCAT("CD",Tong + 1);
		ELSE	
			SET NEW._Ma_con_duong = CONCAT("CD",Tong1 + 1);
		END IF;
	END IF;
END $$
DELIMITER ;

insert into GIAOLO (_long, _lat) values(1,1);
insert into GIAOLO (_long, _lat) values(1,2);
insert into GIAOLO (_long, _lat) values(1,3);
insert into GIAOLO (_long, _lat) values(1,4);
insert into GIAOLO (_long, _lat) values(1,5);


#insert
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

#insert
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
    
#insert
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
#------------------------------------------------#

#--------------------------- [TOAN] -------------------------#
CREATE TABLE TUYENTAU_XE (
	ma_tuyen 			CHAR(4) 							PRIMARY KEY,
    CONSTRAINT 			_name1
		CHECK 	(ma_tuyen like '____'),
		CHECK	(SUBSTRING(ma_tuyen,1,1) = 'B' or SUBSTRING(ma_tuyen,1,1) = 'T'),
		CHECK	(CAST(SUBSTRING(ma_tuyen,2,3) as SIGNED) >= 0 and CAST(SUBSTRING(ma_tuyen,2,3) as SIGNED) <= 999)
);

CREATE TABLE TUYENXEBUS (
    _no INT AUTO_INCREMENT PRIMARY KEY,
    ma_tuyen_tau_xe CHAR(4),
    CONSTRAINT _b
		CHECK(SUBSTRING(ma_tuyen_tau_xe,1,1) = 'B')
);

CREATE TABLE TUYENTAUDIEN (
	ma_tuyen_tau 		CHAR 	PRIMARY KEY,
    ten_tuyen_tau 		VARCHAR(25) 	UNIQUE NOT NULL,
	ma_tuyen_tau_xe 	CHAR(4),
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

ALTER TABLE TUYENXEBUS
	ADD CONSTRAINT fkey_1 
		FOREIGN KEY TUYENXEBUS (ma_tuyen_tau_xe) REFERENCES TUYENTAU_XE (ma_tuyen);
ALTER TABLE TUYENTAUDIEN
	ADD CONSTRAINT fkey_2
		FOREIGN KEY TUYENTAUDIEN (ma_tuyen_tau_xe) REFERENCES TUYENTAU_XE (ma_tuyen);
ALTER TABLE CHUYENTAUXE
	ADD CONSTRAINT fkey_3
		FOREIGN KEY CHUYENTAUXE (ma_tuyen) REFERENCES TUYENTAU_XE (ma_tuyen);
#------------------------------------------------------------#

#--------------------------- [NA] -------------------------#
CREATE TABLE VE
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Loai_ve INT,
    Gia_ve DECIMAL(10,3),
    Ngay_gio_mua DATETIME,
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
ALTER TABLE VE
	ADD CONSTRAINT _fkey_ve FOREIGN KEY VE(Ma_hanh_khach) REFERENCES HANH_KHACH(Ma_hanh_khach);
    

CREATE TABLE VE_LE
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Ma_tuyen  CHAR(4) , 
    Ngay_su_dung DATE,
    Ma_ga_tram_len  CHAR(7),
    Ma_ga_tram_xuong  CHAR(7),
    Gio_len  TIME,
    Gio_xuong TIME,
    CONSTRAINT _ma_ve
		CHECK(SUBSTRING(Ma_ve,1,2) = 'VO'),
	CONSTRAINT _gio
		CHECK(Gio_xuong > Gio_len)
);
ALTER TABLE VE_LE
	ADD CONSTRAINT _fkey_ve_le_1 FOREIGN KEY VE_LE(Ma_ve) REFERENCES VE(Ma_ve);
ALTER TABLE VE_LE
	ADD CONSTRAINT _fkey_ve_le_2 FOREIGN KEY VE_LE(Ma_tuyen) REFERENCES TUYEN_TAU_XE(Ma_tuyen);
ALTER TABLE VE_LE
	ADD CONSTRAINT _fkey_ve_le_3 FOREIGN KEY VE_LE(Ma_ga_tram_len) REFERENCES GA_TRAM(Ma_ga_tram);
ALTER TABLE VE_LE
	ADD CONSTRAINT _fkey_ve_le_4 FOREIGN KEY VE_LE(Ma_ga_tram_xuong) REFERENCES GA_TRAM(Ma_ga_tram);

CREATE TABLE VE_THANG
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Ma_tuyen  CHAR(4),
    Ma_ga_tram_1 CHAR(7),
    Ma_ga_tram_2  CHAR(7),
    CONSTRAINT _ma_ve_thang
		CHECK(SUBSTRING(Ma_ve,1,2) = 'VM')
);
ALTER TABLE VE_THANG
	ADD CONSTRAINT _fkey_ve_thang_1 FOREIGN KEY VE_THANG(Ma_ve) REFERENCES VE(Ma_ve);
ALTER TABLE VE_THANG
	ADD CONSTRAINT _fkey_ve_thang_2 FOREIGN KEY VE_THANG(Ma_tuyen) REFERENCES TUYEN_TAU_XE(Ma_Tuyen);
ALTER TABLE VE_THANG
	ADD CONSTRAINT _fkey_ve_thang_3 FOREIGN KEY VE_THANG(Ma_ga_tram_1) REFERENCES GA_TRAM(Ma_ga_tram);
ALTER TABLE VE_THANG
	ADD CONSTRAINT _fkey_ve_thang_4 FOREIGN KEY VE_THANG(Ma_ga_tram_2) REFERENCES GA_TRAM(Ma_ga_tram);

CREATE TABLE VE_1_NGAY
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Ngay_su_dung DATE,
    CONSTRAINT _ma_ve_1_ngay
		CHECK(SUBSTRING(Ma_ve,1,2) = 'VD')
);
ALTER TABLE VE_1_NGAY
	ADD CONSTRAINT _fkey_ve_1_ngay FOREIGN KEY VE_1_NGAY(Ma_ve) REFERENCES VE(Ma_VE);
#----------------------------------------------------------#

#--------------------- [LUN] ------------------#

#------------------------HOAT DONG VE THANG--------------------------------------------------------
create table HOAT_DONG_VE_THANG(
Ma_ve CHAR(15),
Ngay_su_dung DATE,
Gio_len TIME,
Gio_xuong TIME,
Ga_tram_len CHAR(7),
Ga_tram_xuong CHAR(7),
CONSTRAINT pk12_hoat_dong_ve_thang
PRIMARY KEY(Ma_ve,Ngay_su_dung,Gio_len),
CONSTRAINT DK12_Gio_xuong_Gio_len
CHECK(Gio_xuong > Gio_len),
CONSTRAINT fk12_Ma_ve
FOREIGN KEY (Ma_ve) REFERENCES Ve_thang(Ma_ve),
CONSTRAINT fk12_Ga_tram_len
FOREIGN KEY (Ga_tram_len) REFERENCES Ga_tram(Ma_ga_tram),
CONSTRAINT fk12_Ga_tram_xuong
FOREIGN KEY (Ga_tram_xuong) REFERENCES Ga_tram(Ma_ga_tram)
);
#-------------------------HOAT DONG VE 1 NGAY-------------------------------------------------------
create table hoat_dong_ve_1_ngay(
Ma_ve CHAR(15),
STT INT,
Ma_tuyen CHAR(4),
Ga_tram_len CHAR(7),
Ga_tram_xuong CHAR(7),
Gio_len TIME,
Gio_xuong TIME,
CONSTRAINT pk_hoat_dong_ve_1_ngay
PRIMARY KEY(Ma_ve,STT),
CONSTRAINT DK14_Gio_xuong_Gio_len
CHECK(Gio_xuong > Gio_len),
CONSTRAINT fk14_Ma_ve
FOREIGN KEY (Ma_ve) REFERENCES Ve_1_ngay(Ma_ve),
CONSTRAINT fk14_Ga_tram_len
FOREIGN KEY (Ga_tram_len) REFERENCES Ga_tram(Ma_ga_tram),
CONSTRAINT fk14_Ga_tram_xuong
FOREIGN KEY (Ga_tram_xuong) REFERENCES Ga_tram(Ma_ga_tram)
);
#--------------------------------------------------------------------------------
drop table the_tu;
drop table hanh_khach;
#--------------------------------HANH KHACH------------------------------------------------
create table Hanh_khach(
Ma_hanh_khach CHAR(8) primary key check(Ma_hanh_khach like "KH______")
CHECK	(CAST(SUBSTRING(Ma_hanh_khach,3,6) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_hanh_khach,3,6) as SIGNED) <= 999999),
CMND VARCHAR(9) not null unique,
Nghe_nghiep char(30),
So_dien_thoai VARCHAR(10) unique,
Gioi_tinh char,
Email varchar(100),
Ngay_sinh date
);
#----------------------------THE TU----------------------------------------------------
create table the_tu(
Ma_the_tu VARCHAR(8) primary key check(Ma_the_tu like "TT______")
CHECK	(CAST(SUBSTRING(Ma_the_tu,3,6) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_the_tu,3,6) as SIGNED) <= 999999),
Ngay_mua datetime,
Ma_hanh_khach VARCHAR(8) ,
constraint fk17_Ma_hanh_khach
foreign key (Ma_hanh_khach) references Hanh_khach(Ma_hanh_khach)
);
#---------------------------BANG VE-----------------------------------------------------
CREATE TABLE Bang_ve (
    `ID` INT PRIMARY KEY,
     bus DECIMAL(10 , 3 ),
     ve_1_ngay DECIMAL(10 , 3 ),
    cuoi_tuan DECIMAL(10 , 3 )
);

#-------------------------TRIGGER1-----------------------------------------------
drop trigger check_ga_tram_len_xuong
#--------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER check_ga_tram_len_xuong
BEFORE INSERT
ON Hoat_dong_ve_thang FOR EACH ROW
	BEGIN
    DECLARE Gatramlen CHAR(7);
    DECLARE Gatramxuong CHAR(7);
    
    SELECT Ma_ga_tram_1  INTO Gatramlen FROM Ve_thang WHERE Ma_ve=NEW.Ma_ve;
	SELECT Ma_ga_tram_2  INTO Gatramxuong FROM Ve_thang WHERE Ma_ve=NEW.Ma_ve;
     
    IF Gatramlen != NEW.Ga_tram_len OR Gatramxuong != NEW.Ga_tram_xuong
    THEN signal sqlstate '45000' set message_text = 'Khong the insert duoc vi ma ga tram khong trung khop';
    END IF;
    END $$
DELIMITER ;
#-----------------------TRIGGER 2------------------------------------------------
drop trigger cap_nhat_gia_ve
#--------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER cap_nhat_gia_ve
BEFORE INSERT ON Bang_ve
FOR EACH ROW
BEGIN
	UPDATE VE
    SET Gia_ve=NEW.bus WHERE Loai_ve=0;
    
    UPDATE VE
    SET Gia_ve=NEW.ve_1_ngay WHERE Loai_ve=1 
    AND DAYNAME(STR_TO_DATE(substring(Ma_ve,3,8),'%d%m%Y')) != 'Saturday' 
    AND DAYNAME(STR_TO_DATE(substring(Ma_ve,3,8),'%d%m%Y')) != 'Sunday';
    
    UPDATE VE
    SET Gia_ve=NEW.cuoi_tuan WHERE Loai_ve=2 
    AND DAYNAME(STR_TO_DATE(substring(Ma_ve,3,8),'%d%m%Y')) = 'Saturday' 
    AND DAYNAME(STR_TO_DATE(substring(Ma_ve,3,8),'%d%m%Y')) = 'Sunday';
END $$
DELIMITER ;

#-----------------------------INSERT-------------------------------------------
insert into Ga_tram values ("TT00001");
insert into Ga_tram values ("TT00002");
insert into Ga_tram values ("TT00003");
insert into Tuyen_tau_xe values ("T001");
#--------------------------------------------------------------------------------
insert into Hanh_khach values("KH000001","233316009","Sinh vien","0355665365",'M',"luan.le912@hcmut.edu.vn",'2001-12-9');
insert into VE values ("VM1805202100002",1,50.000,"2021-05-18 12:0:0","KH000001");
insert into Ve_thang values ("VM1805202100002","T001","TT00001","TT00002");
#--------------------------------------------------------------------------------
insert into Hoat_dong_ve_thang values ("VM1805202100002",'2022-05-18','123000','124541',"TT00002","TT00002");
SET SQL_SAFE_UPDATES = 0;
insert into Bang_ve values (1,5.000,10.000,12.000);
SET SQL_SAFE_UPDATES = 1;
#--------------------------------------------------------------------------------

insert into Ga_tram values ("BT00001");
insert into Ga_tram values ("TT00001");
#--------------------------------------------------------------------------------
insert into Ve_thang values ("VM1805202100002");
insert into Ve_thang values ("VM1905202100002");
insert into Ve_thang values ("VM2005202100002");
insert into Ve_thang values ("VM2105202100002");
insert into Ve_thang values ("VM2205202100002");
#--------------------------------------------------------------------------------
insert into Ve_1_ngay values("VD1805202100002");
insert into Ve_1_ngay values("VD1905202100002");
insert into Ve_1_ngay values("VD2005202100002");
insert into Ve_1_ngay values("VD2105202100002");
insert into Ve_1_ngay values("VD2205202100002");
#--------------------------------------------------------------------------------
insert into Tuyen_tau_xe values ("B001");
insert into Tuyen_tau_xe values ("T001");
#--------------------------------------------------------------------------------
insert into Hoat_dong_ve_thang values ("VM1805202100002",'2021-05-18','123000','124541',"BT00001","BT00001");
insert into Hoat_dong_ve_thang values ("VM1905202100002",'2021-05-19','073021','084241',"BT00001","BT00001");
insert into Hoat_dong_ve_thang values ("VM2005202100002",'2021-05-20','082521','104241',"BT00001","BT00001");
insert into Hoat_dong_ve_thang values ("VM2105202100002",'2021-05-21','062121','074241',"BT00001","BT00001");
insert into Hoat_dong_ve_thang values ("VM2205202100002",'2021-05-22','122121','144241',"BT00001","BT00001");
#--------------------------------------------------------------------------------
insert into Hoat_dong_ve_1_ngay values("VD1805202100002",1,"B001","BT00001","BT00001",'123000','124541');
insert into Hoat_dong_ve_1_ngay values("VD1805202100002",2,"B001","BT00001","BT00001",'125000','134541');
insert into Hoat_dong_ve_1_ngay values("VD1905202100002",1,"B001","BT00001","BT00001",'123000','124541');
insert into Hoat_dong_ve_1_ngay values("VD1905202100002",2,"B001","BT00001","BT00001",'133000','134541');
insert into Hoat_dong_ve_1_ngay values("VD1905202100002",3,"B001","BT00001","BT00001",'173000','184541');
#--------------------------------------------------------------------------------
insert into Hanh_khach values("KH000001","233316009","Sinh vien","0355665365",'M',"luan.le912@hcmut.edu.vn",'2001-12-9');
insert into Hanh_khach values("KH000002","233316008","Sinh vien","0355665366",'F',"na.le812@hcmut.edu.vn",'2001-12-8');
insert into Hanh_khach values("KH000003","233316007","Sinh vien","0355665367",'M',"cuong.le712@hcmut.edu.vn",'2001-12-7');
insert into Hanh_khach values("KH000004","233316006","Sinh vien","0355665368",'F',"toan.le612@hcmut.edu.vn",'2001-12-6');
insert into Hanh_khach values("KH000005","233316005","Sinh vien","0355665369",'M',"phong.le512@hcmut.edu.vn",'2001-12-5');
#--------------------------------------------------------------------------------
insert into the_tu values("TT000001",'2020-05-22','KH000001');
insert into the_tu values("TT000002",'2020-05-23','KH000002');
insert into the_tu values("TT000003",'2020-05-25','KH000003');
insert into the_tu values("TT000004",'2020-06-22','KH000003');
insert into the_tu values("TT000005",'2021-01-12','KH000005');
#--------------------------------------------------------------------------------
SELECT CONVERT('2019-04-2', DATE);
#--------------------------------------------------------------------------------

#----------------------------------------------#



#----------------------------- [PHONG] ---------------------------#
CREATE TABLE gheGa_Tram (
    Ma_tuyen CHAR(4),
    STT INT,
    MaGT CHAR(7),
    STT_dung INT,
    Gio_ghe TIME,
    PRIMARY KEY (Ma_tuyen , STT , MaGT)
);

ALTER TABLE gheGa_Tram
	ADD CONSTRAINT _fkey1 FOREIGN KEY (Ma_tuyen) REFERENCES CHUYENTAUXE(ma_tuyen);
ALTER TABLE gheGa_Tram
	ADD CONSTRAINT _fkey2 FOREIGN KEY (STT) REFERENCES CHUYENTAUXE(stt);
    
CREATE TABLE NV (
    MaNV CHAR(6) PRIMARY KEY,
    worktype VARCHAR(20) NOT NULL,
    Bday DATE NOT NULL,
    email CHAR(30),
    sex CHAR,
    mobile_phone INT,
    intern_phone INT
    CONSTRAINT _ma
		CHECK 	(MaNV like 'NV____'),
		CHECK	(CAST(SUBSTRING(MaNV,3,4) as SIGNED) >= 0 and CAST(SUBSTRING(MaNV,3,4) as SIGNED) <= 9999)
);

CREATE TABLE Ga_TramLV (
    MaNV CHAR(6) PRIMARY KEY,
    MaGT CHAR(7)
);

ALTER TABLE Ga_TramLV
	ADD CONSTRAINT _fkey1 FOREIGN KEY (MaNV) REFERENCES NV(MaNV);
ALTER TABLE Ga_TramLV
	ADD CONSTRAINT _fkey2 FOREIGN KEY (MaGT) REFERENCES GA_TRAM(_Ma_ga_tram);
    
CREATE TABLE Gia (
    ID INT PRIMARY KEY,
    bus DECIMAL(10 , 3 ),
    mot_ngay DECIMAL(10 , 3 ),
    cuoi_tuan DECIMAL(10 , 3 )
);
#-----------------------------------------------------------------#