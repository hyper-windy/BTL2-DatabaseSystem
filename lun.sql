create database ass2;
use ass2;
drop database ass2;
create table Ve_thang(
Ma_ve CHAR(15) primary key
);
create table Ve_1_ngay(
Ma_ve CHAR(15) primary key
);
create table Ga_tram(
Ma_ga_tram CHAR(7) primary key
);
create table Tuyen_tau_xe(
Ma_tuyen CHAR(4) primary key
);
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
drop table the_tu;
drop table hanh_khach;

create table Hanh_khach(
Ma_hanh_khach CHAR(8) primary key check(Ma_hanh_khach like "KH______") 
CHECK	((CAST(SUBSTRING(Ma_hanh_khach,3,8) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_hanh_khach,3,8) as SIGNED) <= 999999) ),#or Ma_hanh_khach="KH000000"),
CMND VARCHAR(9) not null unique,
Nghe_nghiep char(30),
So_dien_thoai VARCHAR(10) unique,
Gioi_tinh char,
Email varchar(100),
Ngay_sinh date
);
create table the_tu(
Ma_the_tu VARCHAR(8) primary key check(Ma_the_tu like "TT______")
CHECK	((CAST(SUBSTRING(Ma_the_tu,3,8) as SIGNED) >= 0 and CAST(SUBSTRING(Ma_the_tu,3,8) as SIGNED) <= 999999) ),
Ngay_mua datetime,
Ma_hanh_khach VARCHAR(8) ,
constraint fk17_Ma_hanh_khach
foreign key (Ma_hanh_khach) references Hanh_khach(Ma_hanh_khach)
);

insert into Ga_tram values ("BT00001");
insert into Ga_tram values ("TT00001");

insert into Ve_thang values ("VM1805202100002");
insert into Ve_thang values ("VM1905202100002");
insert into Ve_thang values ("VM2005202100002");
insert into Ve_thang values ("VM2105202100002");
insert into Ve_thang values ("VM2205202100002");

insert into Ve_1_ngay values("VD1805202100002");
insert into Ve_1_ngay values("VD1905202100002");
insert into Ve_1_ngay values("VD2005202100002");
insert into Ve_1_ngay values("VD2105202100002");
insert into Ve_1_ngay values("VD2205202100002");

insert into Tuyen_tau_xe values ("B001");
insert into Tuyen_tau_xe values ("T001");

insert into Hoat_dong_ve_thang values ("VM1805202100002",'2021-05-18','123000','124541',"BT00001","BT00001");
insert into Hoat_dong_ve_thang values ("VM1905202100002",'2021-05-19','073021','084241',"BT00001","BT00001");
insert into Hoat_dong_ve_thang values ("VM2005202100002",'2021-05-20','082521','104241',"BT00001","BT00001");
insert into Hoat_dong_ve_thang values ("VM2105202100002",'2021-05-21','062121','074241',"BT00001","BT00001");
insert into Hoat_dong_ve_thang values ("VM2205202100002",'2021-05-22','122121','144241',"BT00001","BT00001");

insert into Hoat_dong_ve_1_ngay values("VD1805202100002",1,"B001","BT00001","BT00001",'123000','124541');
insert into Hoat_dong_ve_1_ngay values("VD1805202100002",2,"B001","BT00001","BT00001",'125000','134541');
insert into Hoat_dong_ve_1_ngay values("VD1905202100002",1,"B001","BT00001","BT00001",'123000','124541');
insert into Hoat_dong_ve_1_ngay values("VD1905202100002",2,"B001","BT00001","BT00001",'133000','134541');
insert into Hoat_dong_ve_1_ngay values("VD1905202100002",3,"B001","BT00001","BT00001",'173000','184541');

insert into Hanh_khach values("KH000001","233316009","Sinh vien","0355665365",'M',"luan.le912@hcmut.edu.vn",'2001-12-9');
insert into Hanh_khach values("KH000002","233316008","Sinh vien","0355665366",'F',"na.le812@hcmut.edu.vn",'2001-12-8');
insert into Hanh_khach values("KH000003","233316007","Sinh vien","0355665367",'M',"cuong.le712@hcmut.edu.vn",'2001-12-7');
insert into Hanh_khach values("KH00000m","233316006","Sinh vien","0355665368",'F',"toan.le612@hcmut.edu.vn",'2001-12-6');
insert into Hanh_khach values("KH0","233316003","Sinh vien","0355665369",'M',"phong.le512@hcmut.edu.vn",'2001-12-5');

insert into the_tu values("TT000001",'2020-05-22','KH000001');
insert into the_tu values("TT000002",'2020-05-23','KH000002');
insert into the_tu values("TT000003",'2020-05-25','KH000003');
insert into the_tu values("TT000004",'2020-06-22','KH000003');
insert into the_tu values("TT000005",'2021-01-12','KH000005');



