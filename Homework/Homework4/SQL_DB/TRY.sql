START TRANSACTION;

INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
VALUES ("PNTLSN98A41I754J", "Alessandra", "Pantano", 1998);

INSERT INTO RATING(SSN, CodC, Date, Evaluation)
VALUES ("PNTLSN98A41I754J", 4, STR_TO_DATE('01/01/2012', '%d/%m/%Y'), 8);

COMMIT;