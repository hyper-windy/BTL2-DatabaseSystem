create schema `btl`;
use	`btl`;

CREATE TABLE `ghe Ga/Tram` (
    `Ma_tuyen` CHAR(4),
    `STT` INT,
    `MaGT` CHAR(7),
    `STT_dung` INT,
    `Gio_ghe` TIME,
    PRIMARY KEY (`Ma_tuyen` , `STT` , `MaGT`)
);


CREATE TABLE `NV` (
    `MaNV` CHAR(6) PRIMARY KEY,
    `worktype` VARCHAR(20) NOT NULL,
    `Bday` DATE NOT NULL,
    `email` CHAR(30),
    `sex` CHAR,
    `mobile_phone` INT,
    `intern_phone` INT
);

CREATE TABLE `Ga/TramLV` (
    `MaNV` CHAR(6) PRIMARY KEY,
    `MaGT` CHAR(7)
);

CREATE TABLE `Gia` (
    `ID` INT PRIMARY KEY,
    `bus` DECIMAL(10 , 3 ),
    `1_ngay` DECIMAL(10 , 3 ),
    `cuoi_tuan` DECIMAL(10 , 3 )
);


