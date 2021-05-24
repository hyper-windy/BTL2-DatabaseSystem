DROP DATABASE test;
CREATE DATABASE test;

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

-- INSERT INTO VE VALUES('VO012502100001',0 , 50.000, '2020-01-01 10:10:10','88888888');


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
