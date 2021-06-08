SET storage_engine=InnoDB;
SET FOREIGN_KEY_CHECKS=1;
use Gym;

-- Insert data
INSERT INTO Trainer (SSN,Name,Surname,DateOfBirth,Email, PhoneNo)
VALUES ('SMTPLA80N31B791Z','Paul','Smith','1980-12-31','p.smith@email.it',NULL);
INSERT INTO Trainer (SSN,Name,Surname,DateOfBirth,Email, PhoneNo)
VALUES ('KHNJHN81E30C455Y','John','Johnson','1981-05-30','j.johnson@email.it','+2300110303444');
INSERT INTO Trainer (SSN,Name,Surname,DateOfBirth,Email, PhoneNo)
VALUES ('AAAGGG83E30C445A','Peter','Johnson','1981-05-30','p.johnson@email.it','+2300110303444');
INSERT INTO Course (CId,Name,CType,CLevel)
VALUES ('CT100','Spinning for beginners','Spinning ',1);
INSERT INTO Course (CId,Name,CType,CLevel)
VALUES ('CT101','Fitdancing','Music activity',2);
INSERT INTO Course (CId,Name,CType,CLevel)
VALUES ('CT104','Advanced spinning','Spinning',4);
INSERT INTO Schedule (SSN,WeekDay,StartTime,Duration,GymRoom,CId)
VALUES ('SMTPLA80N31B791Z','Monday','10:00',45,'R1','CT100');
INSERT INTO Schedule (SSN,WeekDay,StartTime,Duration,GymRoom,CId)
VALUES ('SMTPLA80N31B791Z','Tuesday','11:00',45,'R1','CT100');
INSERT INTO Schedule (SSN,WeekDay,StartTime,Duration,GymRoom,CId)
VALUES ('SMTPLA80N31B791Z','Tuesday','15:00',45,'R2','CT100');
INSERT INTO Schedule (SSN,WeekDay,StartTime,Duration,GymRoom,CId)
VALUES ('KHNJHN81E30C455Y','Monday','10:00',30,'R2','CT101');
INSERT INTO Schedule (SSN,WeekDay,StartTime,Duration,GymRoom,CId)
VALUES ('KHNJHN81E30C455Y','Monday','11:30',30,'R2','CT104');
INSERT INTO Schedule (SSN,WeekDay,StartTime,Duration,GymRoom,CId)
VALUES ('KHNJHN81E30C455Y','Wednesday','9:00',60,'R1','CT104');

