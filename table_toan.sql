DROP SCHEMA test;
create SCHEMA test;
use test;

CREATE TABLE TUYENTAU_XE (
	ma_tuyen 			CHAR(4) 							PRIMARY KEY,
    CONSTRAINT 			_name1
		CHECK	(SUBSTRING(ma_tuyen,1,1) = 'B' or SUBSTRING(ma_tuyen,1,1) = 'T'),
		CHECK	(CAST(SUBSTRING(ma_tuyen,2,1) as SIGNED) >= 0 and CAST(SUBSTRING(ma_tuyen,2,1) as SIGNED) <= 9),
        CHECK	(CAST(SUBSTRING(ma_tuyen,3,1) as SIGNED) >= 0 and CAST(SUBSTRING(ma_tuyen,3,1) as SIGNED) <= 9),
        CHECK	(CAST(SUBSTRING(ma_tuyen,4,1) as SIGNED) >= 0 and CAST(SUBSTRING(ma_tuyen,4,1) as SIGNED) <= 9)
);

INSERT INTO TUYENTAU_XE VALUES ('B00A');

INSERT INTO TUYENTAU_XE VALUES ('T001');

CREATE TABLE TUYENXEBUS (
    _no INT AUTO_INCREMENT PRIMARY KEY,
    ma_tuyen_tau_xe CHAR(4),
    CONSTRAINT _b
		CHECK(SUBSTRING(ma_tuyen_tau_xe,1,1) = 'B')
);
        
INSERT INTO TUYENXEBUS VALUES (NULL, 'B000');

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