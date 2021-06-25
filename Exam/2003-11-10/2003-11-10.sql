--1.A
SELECT DISTINCT CodC
FROM PROGRAMMA
WHERE OraInizio>=20
GROUP BY Sala,CodC
HAVING COUNT(*)>1

--1.B
SELECT CodC, COUNT(*) VenditeSuperiori#
FROM PROGRAMMA P, BIGLIETTO-VENDUTO BV
WHERE P.CodC IN
    (
        SELECT CodC
        FROM PROGRAMMA
        GROUP BY CodC
        HAVING COUNT(DISTINCT Sala)>=5
    )
    AND P.Data=BV.Data AND P.OraInizio=bv.OraInizio AND P.Sala=BV.Sala
    AND Prezzo>
    (
        SELECT AVG(BV1.Prezzo)
        FROM BIGLIETTO-VENDUTO BV1, PROGRAMMA P1
        WHERE BV1.Data=P1.Data AND BV1.OraInizio=P1.OraInizio AND BV1.Sala=P1.Sala
            AND P1.CodC=P.CodC
        GROUP BY P1.CodC
    )
GROUP BY P.CodC