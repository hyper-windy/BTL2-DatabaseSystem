CREATE TABLE GIAOLO(
    _long 		FLOAT(10,7)		NOT NULL,
    _lat 		FLOAT(10,7)		NOT NULL,
	_id			int				NOT NULL		UNIQUE		AUTO_INCREMENT);

/*insert into GIAOLO
	values(1,1,NULL);
insert into GIAOLO
	values(2,1,NULL);
insert into GIAOLO
	values(1,3,NULL);
insert into GIAOLO
	values(1,5,NULL);
insert into GIAOLO
	values(17,1,NULL);*/
    
ALTER TABLE GIAOLO
	ADD	_Ma_giao_lo VARCHAR(8) DEFAULT NULL;
UPDATE GIAOLO SET _Ma_giao_lo = CONCAT("GT",_id);
ALTER TABLE GIAOLO
	ADD		PRIMARY KEY (_Ma_giao_lo);
ALTER TABLE GIAOLO
	DROP COLUMN	_id;
   
CREATE TABLE DOANDUONG(
	_Ma_giao_lo_1	varchar(8),
    _Ma_giao_lo_2	varchar(8),
    _Ma_con_duong 	varchar(16),
    _STT 			int		UNSIGNED	NOT NULL,	
    _Chieu_dai		int 	UNSIGNED	NOT NULL,
    PRIMARY KEY(_Ma_giao_lo_1, _Ma_giao_lo_2) );
   
#insert

CREATE TABLE CONDUONG(
    _Ten_duong		varchar(100)	UNIQUE		NOT NULL,
    _id			int				NOT NULL		UNIQUE		AUTO_INCREMENT);
    
#insert

ALTER TABLE CONDUONG
	ADD	_Ma_con_duong VARCHAR(8) DEFAULT NULL;
UPDATE CONDUONG SET _Ma_con_duong = CONCAT("CD",_id);
ALTER TABLE CONDUONG
	ADD		PRIMARY KEY (_Ma_con_duong);
ALTER TABLE CONDUONG
	DROP COLUMN	_id;  

CREATE TABLE GA_TRAM(
    _Ma_ga_tram 	char(7)			PRIMARY KEY,
    _Dia_chi		varchar(100)	NOT NULL,
    _Ten			varchar(100)	UNIQUE		NOT NULL,
    _Ga_tram		bool			NOT NULL,
    _Ma_giao_lo_1	varchar(8) 	,
    _Ma_giao_lo_2	varchar(8) 	,    
    constraint _name1
		check ( substr(_Ma_ga_tram,1,1) = 'T' OR substr(_Ma_ga_tram,1,1) = 'B' ),
	constraint _name2
        check ( substr(_Ma_ga_tram,2,1) = 'T'),
	constraint _name3
        check ( cast(substr(_Ma_ga_tram,3,5) as SIGNED) >= 0 AND cast(substr(_Ma_ga_tram,3,5) as SIGNED) <=99999));
   
#insert

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


    
