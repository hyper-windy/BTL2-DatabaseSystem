CREATE DATABASE ASS_2;

USE ASS_2;

 -- DROP TABLE VE_1_NGAY;
 -- DROP TABLE VE_LE;
 -- DROP TABLE VE_THANG;
 -- DROP TABLE  GA_TRAM;
 -- DROP TABLE TUYEN_TAU_XE;
 -- DROP TABLE 	VE;


CREATE TABLE TUYEN_TAU_XE (  
	Ma_tuyen VARCHAR(50) NOT NULL,   
    PRIMARY KEY(Ma_tuyen) 
);
CREATE TABLE GA_TRAM
(
	Ma_ga_tram  VARCHAR(50) NOT NULL,
    PRIMARY KEY(Ma_ga_tram)
);

drop TABLE ve;
use test;

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

INSERT INTO VE VALUES('VO012502100001',0 , 50.000, '2020-01-01 10:10:10','88888888');


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
		CHECK(Gio_xuong > Gio_len),
    FOREIGN KEY(Ma_ve) REFERENCES VE(Ma_ve),
    FOREIGN KEY(Ma_tuyen) REFERENCES TUYEN_TAU_XE(Ma_tuyen),
    FOREIGN KEY(Ma_ga_tram_len) REFERENCES GA_TRAM(Ma_ga_tram),
    FOREIGN KEY(Ma_ga_tram_xuong) REFERENCES GA_TRAM(Ma_ga_tram)
);

CREATE TABLE VE_THANG
(
	Ma_ve  VARCHAR(50) ,
    Ma_tuyen  VARCHAR(50) NOT NULL,
    Ma_ga_tram_1  VARCHAR(50) NOT NULL,
    Ma_ga_tram_2   VARCHAR(50) NOT NULL,
    PRIMARY KEY(Ma_ve),
	FOREIGN KEY(Ma_ve) REFERENCES VE(Ma_ve), -- mã ve "VM"
	FOREIGN KEY(Ma_tuyen) REFERENCES TUYEN_TAU_XE(Ma_Tuyen), 
	FOREIGN KEY(Ma_ga_tram_1) REFERENCES GA_TRAM(Ma_ga_tram), 
	FOREIGN KEY(Ma_ga_tram_2) REFERENCES GA_TRAM(Ma_ga_tram),
    CHECK (Ma_ve = 'VM')
);
CREATE TABLE VE_1_NGAY
(
	Ma_ve  VARCHAR(50),
    Ngay_su_dung DATE,
    PRIMARY KEY(Ma_ve),
    FOREIGN KEY(Ma_ve) REFERENCES VE(Ma_ve), -- ma ve"VD"
    CHECK (Ma_ve = 'VD')
);



