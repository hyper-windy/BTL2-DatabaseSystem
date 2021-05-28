use ass2;
drop database ass2;
create database ass2;
#--------------------------VE------------------------------------------------------
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
    
#-------------------VE LE-------------------------------------------------------------
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

#---------------------VE THANG-----------------------------------------------------------
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
    
#-----------------------VE 1 NGAY ---------------------------------------------------------
CREATE TABLE VE_1_NGAY
(
	Ma_ve  CHAR(15) PRIMARY KEY,
    Ngay_su_dung DATE,
    CONSTRAINT _ma_ve_1_ngay
		CHECK(SUBSTRING(Ma_ve,1,2) = 'VD')
);
ALTER TABLE VE_1_NGAY
	ADD CONSTRAINT _fkey_ve_1_ngay FOREIGN KEY VE_1_NGAY(Ma_ve) REFERENCES VE(Ma_VE);
    
#-----------------------GA TRAM---------------------------------------------------------
create table Ga_tram(
Ma_ga_tram CHAR(7) primary key
);
create table Tuyen_tau_xe(
Ma_tuyen CHAR(4) primary key
);

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
