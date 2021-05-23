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
CREATE TABLE VE
(
	Ma_ve  VARCHAR(50) ,
    Loai_ve INT ,
    Gia_ve DECIMAL ,
    Ngay_gio_mua DATETIME ,
    Ma_hanh_khach  VARCHAR(50) ,
    PRIMARY KEY(Ma_ve),
    CHECK( Loai_ve >= 0 and Loai_ve <= 2)
);
CREATE TABLE VE_LE
(
	Ma_ve  VARCHAR(50) ,
    Ma_tuyen  VARCHAR(50) , 
    Ngay_su_dung DATE,
    Ma_ga_tram_len  VARCHAR(50),
    Ma_ga_tram_xuong  VARCHAR(50),
    Gio_len  TIME,
    Gio_xuong TIME,
    PRIMARY KEY(Ma_ve),
    FOREIGN KEY(Ma_ve) REFERENCES VE(Ma_ve), -- mã ve "VO"
    FOREIGN KEY(Ma_tuyen) REFERENCES TUYEN_TAU_XE(Ma_tuyen),
    FOREIGN KEY(Ma_ga_tram_len) REFERENCES GA_TRAM(Ma_ga_tram),
    FOREIGN KEY(Ma_ga_tram_xuong) REFERENCES GA_TRAM(Ma_ga_tram),
    CHECK(Gio_len < Gio_xuong AND Ma_ve = 'VO')
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



