--1.b
SELECT Name, Scientific-Field, COUNT(*)
FROM DEPARTMENT D, PHD_COMPETITION PC
WHERE D.DCode NOT IN
    (
        SELECT DCode
        FROM PHD_COMPETITION
        WHERE #ofOpenPosition<7
    )
    AND D.DCode=PC.DCode
    WHERE PostingDate>="2014-03-01"
GROUP BY Name, Scientific-Field


--1.c
SELECT Name
FROM STUDENT S, STUDENT_PARTECIPATE_PHD_COMPETITION SPPC1, DEPARTMENT D1
WHERE S.StudentID IN
    (
    SELECT StudentID
    FROM STUDENT_PARTECIPATE_PHD_COMPETITION  SPPC, DEPARTMENT D
    WHERE SPPC.DCode=D.DCode
    GROUP BY StudentID
    HAVING COUNT(DISTINCT Scientific-Field)>=3
    )
    AND SPPC1.DCode=D1.DCode AND S.StudentID=SPPC1.StudentID
GROUP BY S.StudentID, S.Name, D1.Scientific-Field
HAVING COUNT(*)=
    (
        SELECT COUNT(*)
        FROM PHD_COMPETITION PHD, DEPARTMENT D2
        WHERE PHD.DCode=D2.DCode
            AND D2.Scientific-Field=D1.Scientific-Field
    )