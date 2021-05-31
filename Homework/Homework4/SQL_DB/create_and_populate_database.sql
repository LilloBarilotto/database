-- create an empty database. Name of the database: 
SET storage_engine=InnoDB;
SET FOREIGN_KEY_CHECKS=1;
CREATE DATABASE IF NOT EXISTS Homework4;

-- use Homework4
use Homework4;


-- drop tables if they already exist
DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS CONTENT;
DROP TABLE IF EXISTS RATING;

-- create tables

CREATE TABLE USERS(
	SSN CHAR(20) NOT NULL,
	Name CHAR(50) NOT NULL ,
	Surname CHAR(50) NOT NULL ,
	YearOfBirth SMALLINT NOT NULL ,
	PRIMARY KEY (SSN)
);

CREATE TABLE CONTENT (
	CodC SMALLINT AUTO_INCREMENT,
	Category CHAR(50) NOT NULL ,
	Duration SMALLINT NOT NULL ,
	Title CHAR(50) NOT NULL,
	Description CHAR(50),
	PRIMARY KEY (CodC)
);

CREATE TABLE RATING (
	SSN CHAR(20) NOT NULL ,
	CodC SMALLINT NOT NULL,
	Date DATE NOT NULL ,
	Evaluation SMALLINT NOT NULL,
	PRIMARY KEY (SSN,CodC,Date),
	FOREIGN KEY (SSN)
		REFERENCES USERS(SSN) 
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (CodC)
		REFERENCES CONTENT(CodC) 
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT chk_Evaluation CHECK (Evaluation>=1 and Evaluation<=10)
);

-- insert into USERS
INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("RMNNCL99E16A494V", "Nicolò", "Romano", 1999);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("GZZSST00M22E532H", "Sebastiano", "Guzzone", 2000);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("VLRPGL00E15K555K", "Valerio", "Pagliarino", 2000);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("BRCLNR00M62E532V", "Eleonora", "Breci", 2000);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("PSNPLA89A01H501F", "Paolo", "Pasini", 1989);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("NCLSMN00A01L219L", "Simone", "Nicol", 2000);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("CMRPLA00A01L219G", "Mannaggiaa", "Camurati", 1301);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("RMNNCL99E16I754H", "PotevaMettermi", "Almeno24", 1300);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("RMNN12E134FGGX4H", "Carla", "Spagnolello", 1998);

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES	("FFFNCL99E16I754H", "Paolo", "Tilli", 1981);


-- insert into content
INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("History", 60 , "Sguzzamento", "Autobiografia di me.");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("History", 25 , "America", "E gli americani vincono!! cit.");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("History", 33 , "Gli anni di", "Sono un burlone");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("Adult", 50 , "Please $sp, push inside me!", "Ricorda di fare la pop in tempo...");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("Fantasy", 42 , "Alla prima compilazione non da errori", "Te piaciss ehhh, questo si che e' strong");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("Adult", 60 , "e^(i(pi))=-1", "Questo e' proprio hot scusate...");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("Fantasy", 60 , "Run 5/5 ... Failure:0", "Scusate troppo fantasy");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("Fantasy", 40 , "Mission Possible", "Alla prima missione va tutto liscio");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("Fantasy", 5 , "Architetto supera l'ingegnere", "E poi si e' svegliato tutto sudato");

INSERT INTO CONTENT(Category, Duration, Title, Description)
VALUES	("Fiction", 11 , "Collegio Einaudi", "Buh non lo so");


-- insert into RATING   '%d/%m/%Y'
INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("RMNNCL99E16A494V", 1, STR_TO_DATE('17/12/2015', '%d/%m/%Y'), 4);
INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("RMNNCL99E16A494V", 4, STR_TO_DATE('01/01/2012', '%d/%m/%Y'), 1);
INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("RMNNCL99E16A494V", 7, STR_TO_DATE('11/11/2013', '%d/%m/%Y'), 10);
INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("RMNNCL99E16A494V", 10, STR_TO_DATE('10/10/2010', '%d/%m/%Y'), 5);

INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("GZZSST00M22E532H", 3, STR_TO_DATE('22/08/2020', '%d/%m/%Y'), 7);
INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("GZZSST00M22E532H", 3, STR_TO_DATE('23/01/2005', '%d/%m/%Y'), 4);

INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("GZZSST00M22E532H", 2, STR_TO_DATE('10/04/2010', '%d/%m/%Y'), 5);
INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("GZZSST00M22E532H", 5, STR_TO_DATE('11/03/2014', '%d/%m/%Y'), 10);

INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("BRCLNR00M62E532V", 6, STR_TO_DATE('23/11/2019', '%d/%m/%Y'), 7);
INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("BRCLNR00M62E532V", 9, STR_TO_DATE('13/04/2021', '%d/%m/%Y'), 5);
INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("BRCLNR00M62E532V", 2, STR_TO_DATE('10/02/2020', '%d/%m/%Y'), 4);
