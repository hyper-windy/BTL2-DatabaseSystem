-- 1 --
DELIMITER $$
CREATE PROCEDURE LoTrinhTuyenXeTau(IN ma_tuyen CHAR(4))
BEGIN
   SELECT _Ten
   FROM CHUYEN_TAU_XE_GHE_GA_TRAM ch, GA_TRAM gt
   WHERE gt._Ma_ga_tram = ch._Ma_ga_tram AND ch._Ma_tuyen = ma_tuyen
   ORDER BY ch._STT;
END; $$
DELIMITER ;

-- 2 --
DELIMITER $$
CREATE PROCEDURE ThongKeLuotNguoi (
	IN ma_tuyen CHAR(4), 
    IN fromDate DATE, 
    IN toDate DATE
)
BEGIN
	DECLARE numberofDays 	INT;
    DECLARE i 				INT DEFAULT 0;
    DECLARE Tong1 			INT DEFAULT 0;
    DECLARE Tong2 			INT DEFAULT 0;
    DECLARE Tong3 			INT DEFAULT 0;

    CREATE TABLE Bang (
		Ngay	DATE 	PRIMARY KEY,
        Tong	INT);
    
    SET numberofDays = DATEDIFF(toDate, fromDate);
    WHILE (i<=numberofDays) DO
		SELECT COUNT(*) AS Tong1 INTO Tong1 
		FROM VE_LE
        WHERE Ngay_su_dung = DATE_ADD(fromDate, INTERVAL i DAY) AND Ma_tuyen = ma_tuyen;   
		
		SELECT COUNT(*) AS Tong2 INTO Tong2 
		FROM VE_THANG vt, HOAT_DONG_VE_THANG hdvt
        WHERE vt.Ma_ve = hdvt.Ma_ve AND hdvt.Ngay_su_dung = DATE_ADD(fromDate, INTERVAL i DAY) AND vt.Ma_tuyen = ma_tuyen;  
		
        SELECT COUNT(*) AS Tong3 INTO Tong3 
		FROM VE_NGAY vn, hoat_dong_ve_1_ngay hdvn
        WHERE vn.Ma_ve = hdvn.Ma_ve AND vn.Ngay_su_dung = DATE_ADD(fromDate, INTERVAL i DAY) AND hdvn.Ma_tuyen = ma_tuyen;
        
        insert into Bang values (DATE_ADD(fromDate, INTERVAL i DAY), Tong1+Tong2+Tong3);
	END WHILE;
    
     SELECT Bang;
END; $$
DELIMITER ;