use ass2;

CREATE TABLE Ve_thang (
    Ma_ve VARCHAR(15) PRIMARY KEY
);
CREATE TABLE Ve_1_ngay (
    Ma_ve VARCHAR(15) PRIMARY KEY
);
CREATE TABLE Ga_tram (
    Ma_ga_tram VARCHAR(7) PRIMARY KEY
);
CREATE TABLE Tuyen_tau_xe (
    Ma_tuyen VARCHAR(4) PRIMARY KEY
);
CREATE TABLE HOAT_DONG_VE_THANG (
    Ma_ve VARCHAR(15),
    Ngay_su_dung DATE,
    Gio_len TIME,
    Gio_xuong TIME,
    Ga_tram_len VARCHAR(7),
    Ga_tram_xuong VARCHAR(7),
    CONSTRAINT pk12_hoat_dong_ve_thang PRIMARY KEY (Ma_ve , Ngay_su_dung , Gio_len),
    CONSTRAINT DK12_Gio_xuong_Gio_len CHECK (Gio_xuong > Gio_len),
    CONSTRAINT fk12_Ma_ve FOREIGN KEY (Ma_ve)
        REFERENCES Ve_thang (Ma_ve),
    CONSTRAINT fk12_Ga_tram_len FOREIGN KEY (Ga_tram_len)
        REFERENCES Ga_tram (Ma_ga_tram),
    CONSTRAINT fk12_Ga_tram_xuong FOREIGN KEY (Ga_tram_xuong)
        REFERENCES Ga_tram (Ma_ga_tram)
);
CREATE TABLE hoat_dong_ve_1_ngay (
    Ma_ve VARCHAR(15),
    STT INT,
    Ma_tuyen VARCHAR(4),
    Ga_tram_len VARCHAR(7),
    Ga_tram_xuong VARCHAR(7),
    Gio_len TIME,
    Gio_xuong TIME,
    CONSTRAINT pk_hoat_dong_ve_1_ngay PRIMARY KEY (Ma_ve , STT),
    CONSTRAINT DK14_Gio_xuong_Gio_len CHECK (Gio_xuong > Gio_len),
    CONSTRAINT fk14_Ma_ve FOREIGN KEY (Ma_ve)
        REFERENCES Ve_1_ngay (Ma_ve),
    CONSTRAINT fk14_Ga_tram_len FOREIGN KEY (Ga_tram_len)
        REFERENCES Ga_tram (Ma_ga_tram),
    CONSTRAINT fk14_Ga_tram_xuong FOREIGN KEY (Ga_tram_xuong)
        REFERENCES Ga_tram (Ma_ga_tram)
);
DROP TABLE the_tu;
DROP TABLE hanh_khach;
CREATE TABLE Hanh_khach (
    Ma_hanh_khach VARCHAR(8) PRIMARY KEY CHECK (Ma_hanh_khach LIKE 'KH______'),
    CMND VARCHAR(9) NOT NULL UNIQUE,
    Nghe_nghiep CHAR(30),
    So_dien_thoai VARCHAR(10) UNIQUE,
    Gioi_tinh CHAR,
    Email VARCHAR(100),
    Ngay_sinh DATE
);
CREATE TABLE the_tu (
    Ma_the_tu VARCHAR(8) PRIMARY KEY CHECK (Ma_the_tu LIKE 'TT______'),
    Ngay_mua DATETIME,
    Ma_hanh_khach VARCHAR(8) CHECK (Ma_hanh_khach LIKE 'KH______'),
    CONSTRAINT fk17_Ma_hanh_khach FOREIGN KEY (Ma_hanh_khach)
        REFERENCES Hanh_khach (Ma_hanh_khach)
);

INSERT INTO Ga_tram VALUES ("BT00001");
INSERT INTO Ga_tram VALUES ("TT00001");

INSERT INTO Ve_thang VALUES ("VM1805202100002");
INSERT INTO Ve_thang VALUES ("VM1905202100002");
INSERT INTO Ve_thang VALUES ("VM2005202100002");
INSERT INTO Ve_thang VALUES ("VM2105202100002");
INSERT INTO Ve_thang VALUES ("VM2205202100002");

INSERT INTO Ve_1_ngay VALUES("VD1805202100002");
INSERT INTO Ve_1_ngay VALUES("VD1905202100002");
INSERT INTO Ve_1_ngay VALUES("VD2005202100002");
INSERT INTO Ve_1_ngay VALUES("VD2105202100002");
INSERT INTO Ve_1_ngay VALUES("VD2205202100002");

INSERT INTO Tuyen_tau_xe VALUES ("B001");
INSERT INTO Tuyen_tau_xe VALUES ("T001");

INSERT INTO Hoat_dong_ve_thang VALUES ("VM1805202100002",'2021-05-18','123000','124541',"BT00001","BT00001");
INSERT INTO Hoat_dong_ve_thang VALUES ("VM1905202100002",'2021-05-19','073021','084241',"BT00001","BT00001");
INSERT INTO Hoat_dong_ve_thang VALUES ("VM2005202100002",'2021-05-20','082521','104241',"BT00001","BT00001");
INSERT INTO Hoat_dong_ve_thang VALUES ("VM2105202100002",'2021-05-21','062121','074241',"BT00001","BT00001");
INSERT INTO Hoat_dong_ve_thang VALUES ("VM2205202100002",'2021-05-22','122121','144241',"BT00001","BT00001");

INSERT INTO Hoat_dong_ve_1_ngay VALUES("VD1805202100002",1,"B001","BT00001","BT00001",'123000','124541');
INSERT INTO Hoat_dong_ve_1_ngay VALUES("VD1805202100002",2,"B001","BT00001","BT00001",'125000','134541');
INSERT INTO Hoat_dong_ve_1_ngay VALUES("VD1905202100002",1,"B001","BT00001","BT00001",'123000','124541');
INSERT INTO Hoat_dong_ve_1_ngay VALUES("VD1905202100002",2,"B001","BT00001","BT00001",'133000','134541');
INSERT INTO Hoat_dong_ve_1_ngay VALUES("VD1905202100002",3,"B001","BT00001","BT00001",'173000','184541');

INSERT INTO Hanh_khach VALUES("KH000001","233316009","Sinh vien","0355665365",'M',"luan.le912@hcmut.edu.vn",'2001-12-9');
INSERT INTO Hanh_khach VALUES("KH000002","233316008","Sinh vien","0355665366",'F',"na.le812@hcmut.edu.vn",'2001-12-8');
INSERT INTO Hanh_khach VALUES("KH000003","233316007","Sinh vien","0355665367",'M',"cuong.le712@hcmut.edu.vn",'2001-12-7');
INSERT INTO Hanh_khach VALUES("KH000004","233316006","Sinh vien","0355665368",'F',"toan.le612@hcmut.edu.vn",'2001-12-6');
INSERT INTO Hanh_khach VALUES("KH000005","233316005","Sinh vien","0355665369",'M',"phong.le512@hcmut.edu.vn",'2001-12-5');

INSERT INTO the_tu VALUES("TT000001",'2020-05-22','KH000001');
INSERT INTO the_tu VALUES("TT000002",'2020-05-23','KH000002');
INSERT INTO the_tu VALUES("TT000003",'2020-05-25','KH000003');
INSERT INTO the_tu VALUES("TT000004",'2020-06-22','KH000003');
INSERT INTO the_tu VALUES("TT000005",'2021-01-12','KH000005');

set date_format(now(),"%d-%m-%Y");
