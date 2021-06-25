--1.B
SELECT AName, TypeOfActivity
FROM BABY_PARKING_ACTIVITY BPA
WHERE MinAge>=1 AND MaxAge<=3
    AND ACode IN
        (
            SELECT ACode
            FROM EDUCATOR_FOR_ACTIVITY
            GROUP BY ACode
            HAVING COUNT(*)>=3
            AND SUM(Total#EstimatedHours)<30
        )

--1.C
SELECT AName, EName, SUM(#Hours) as TotalHours#
FROM BABY_PARKING_ACTIVITY BPA, EDUCATOR E, ACTIVITY_REGISTER A
WHERE BPA.ACode IN
    (
        SELECT A1.ACode
        FROM ACTIVITY_REGISTER A1
        GROUP BY A1.ACode
        HAVING SUM(#Hours)>
            (  
                SELECT SUM(Total#EstimatedHours)
                FROM EDUCATOR_FOR_ACTIVITY EFA1
                WHERE EFA1.ACode=A1.ACode
            )
    )
    AND BPA.ACode=A.ACode AND E.SSN=A.SSN
GROUP BY A.ACode, A.AName, E.SSN, E.AName