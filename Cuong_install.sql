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
    
