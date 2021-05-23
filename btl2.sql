create schema `btl`;
use	`btl`;

create table `ghe Ga/Tram` (
`Ma_tuyen` char(4),
`STT` int,
`MaGT` char(7),
`STT_dung` int,
`Gio_ghe` time,
primary key(`Ma_tuyen`,`STT`,`MaGT`) );


create table `NV`(
`MaNV` char(6) primary key,
`worktype` varchar(20) not null,
`Bday` date not null,
`email` char(30),
`sex` char,
`mobile_phone` int,
`intern_phone` int );

create table `Ga/TramLV` (
`MaNV` char(6) primary key,
`MaGT` char(7) );

create table `Gia`(
`ID` int primary key,
`bus` decimal(10,3),
`1_ngay` decimal(10,3),
`cuoi_tuan` decimal(10,3) );


