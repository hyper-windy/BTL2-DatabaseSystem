create schema btl;
use	btl;

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


