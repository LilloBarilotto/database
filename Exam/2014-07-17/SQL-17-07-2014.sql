--1.B
SELECT Name, Nation,COUNT(*) AS Reservation#, SUM(#Adults) AS Adults#, SUM(Amount) AS TotalAmount
FROM TOURIST T, RESERVATION_STAY R
WHERE T.TouristID=R.TouristID AND
    T.BirthDate>="1980/01/01"
    AND T.TouristID IN
    (
        SELECT TouristID
        FROM RESERVATION_STAY
        GROUP BY ResortCode, TouristID
        HAVING COUNT(*)>=3
    )
GROUP BY T.TouristID, T.Name, T.Nation


--1.C
SELECT ResortCode, CompanyName
FROM RESORT
WHERE #Stars=4
    AND (ResortCode, CompanyName) NOT IN
    (
        SELECT ResortCode, CompanyName
        FROM RESERVATION_STAY
        WHERE DownPayment=Amount
    )
    AND (ResortCode, CompanyName) IN
    (
        SELECT ResortCode, CompanyName
        FROM RESERVATION_STAY R1, TOURIST T1
        WHERE R1.TouristID=T1.TouristID
            AND T1.Nation="Italy"
        GROUP BY ResortCode, CompanyName
        HAVING COUNT(*)>
            (
                SELECT COUNT(*)
                FROM RESERVATION_STAY R2, TOURIST T2
                WHERE R2.TouristID=T2.TouristID
                    AND  T2.Nation="German"
                    AND  R2.CompanyName=R1.CompanyName AND R2.ResortCode=R1.ResortCode
            )
    )
    