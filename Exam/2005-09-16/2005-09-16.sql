--1.B
SELECT Matr, Nome
FROM DIPENDENTE D, FERIE F
WHERE D.Matr=F.Matr
    AND DurataInGiorni >
    (
        SELECT AVG(DurataInGiorni)
        FROM FERIE F1, DIPENDENTE D1
        WHERE F1.Matr=D1.Matr
            AND D1.Mansione=D.Mansione AND D1.CodD=D.CodD 
    )
GROUP BY Matr, Nome
HAVING COUNT(*)=1

--1.C
SELECT D.CodD
FROM DIPARTIMENTO D
WHERE NOT EXISTS
    (
        SELECT *
        FROM DIPENDENTE D1, FERIE F
        WHERE D1.Matr=F.Matr
            AND D1.CodD=D.CodD
        GROUP BY Matr
        HAVING SUM(DurataInGiorni)>21
    )
