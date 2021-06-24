--1.A
SELECT SSN, PName, COUNT(*)
FROM PATIENT P, BOOKING B
WHERE P.SSN=B.SSN
    AND Date<="2005/11/31" AND Date>="20005/11/01"
    AND P.SSN IN
    (
        SELECT SSN
        FROM BOOKING B
        WHERE VCode IS NOT NULL
            AND Date<="2005/12/31" AND Date>="2005/01/01"
        GROUP BY DCode, SSN
        HAVING COUNT(*)>2  
    )
GROUP BY P.SSN, P.PName;

--1.B
SELECT SSN, PName
FROM PATIENT
WHERE BirthDate>"1960/12/31"
    AND SSN NOT IN
    (
        SELECT SSN
        FROM BOOKING B, SPECIALIST_VISIT SV
        WHERE B.VCode=SV.VCode
            AND VType="Cardiologist"
    );


-------------------------------------------
--2.A
SELECT Name, Surname
FROM CUSTOMER
WHERE SSN NOT IN
    (
        SELECT SSN
        FROM RENTAL_RESERVATION RR, CAR C
        WHERE C.Maker="Mercedes"
            AND RR.NumberPlate=C.NumberPlate
        GROUP BY SSN, StartDate
        HAVING COUNT(*)>1
        --HAVING COUNT(DISTINCT C.NumberPlate)>1
    );

--2.B
SELECT CRCode, CRName, COUNT(*)
FROM CAR_RENTAL CR, RENTAL_RESERVATION RR
WHERE CR.CRCode=RR.CRCode
    AND ReservationDate<="2006/12/31" AND ReservationDate>="2006/01/01"
    AND CR.CRCode IN
    (
        SELECT CRCode
        FROM RENTAL_RESERVATION
        WHERE ReservationDate<="2006/11/31" AND ReservationDate>="2006/11/01"
        GROUP BY CRCode
        HAVING COUNT(*)>=30
    )
GROUP BY CR.CRCode, CR.CRName;

-----------------------------------
--3.A
SELECT OwnerName, Address, City
FROM PHARMACY
WHERE PCode NOT IN 
    (
        SELECT PCode
        FROM SALE S, DRUG D
        WHERE S.DCode=D.DCode
            AND ActivitePrinciple="Paracetamol"
    );

--3.B
SELECT PCode, OwnerName, SUM(Quantity) AS BayerDrugsSold#
FROM PHARMACY P, SALE S, DRUG D
WHERE PCode IN
    (
        SELECT PCode
        FROM SALE
        GROUP BY PCode
        HAVING SUM(Quantity) >
            (
                SELECT AVG(*)
                FROM (
                        SELECT SUM(Quantity)
                        FROM SALE
                        GROUP BY PCode
                    )
            )
     )
     AND S.PCode=P.PCode AND S.DCode=D.DCode
     AND Date<="2007/12/31" AND Date>="2007/01/01"
     AND Maker="Bayer"
GROUP BY PCode, OwnerNAme

---------------------
--4.A
SELECT LID, FirstName, LAstName
FROM LIFEGUARD
WHERE HomeCity="Ostuni"
    AND LID NOT IN
        (
            SELECT LifeguardInCharge
            FROM BEACH
        )
    AND LID IN
        (
            SELECT Lifeguard
            FROM RESCUE 
            GROUP BY Lifeguard, BeachCity, Date
            HAVING COUNT(*)>1
        )

--4.B
SELECT BeachAddress, BeachCity, COUNT(DISTINCT Lifeguard)
FROM RESCUE
WHERE BeachCity IN
    (
        SELECT BeachCity
        FROM BEACH
        WHERE Capacity > 
            (
                SELECT AVG(Capacity)
                FROM BEACH
            )
        GROUP BY BeachCity
        HAVING COUNT(*)>=10
    )
GROUP BY BeachAddress, BeachCity


-----------
--5.A
SELECT ACode, AName
FROM ATHLETE
WHERE ACode NOT IN
    (
        SELECT ACode
        FROM ATTENDANCE A, COMPETITON C
        WHERE C.CType="Super G"
            AND A.CCode=C.CCode
    )

--5.B
SELECT ACode, AName, COUNT(*) As Competiton#, MIN(Position) --MAX(Position)??
FROM ATHLETE A, ATTENDANCE AT
WHERE   A.ACode=AT.ACode
    AND (Country="Italy" OR Country="Spain")
    AND A.ACode IN
    (
        SELECT ACode
        FROM ATTENDACE AT1, COMPETITION C
        WHERE AT1.CCode=C.CCode
            AND C.CType="Super G"
        GROUP BY ACode
        HAVING COUNT(*)>=10
    )     
GROUP BY ACode, AName