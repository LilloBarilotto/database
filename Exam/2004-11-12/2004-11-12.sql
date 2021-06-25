--1.A
SELECT DISTINCT NumTelChiamante
FROM CHIAMATA
WHERE NumTelChiamante NOT IN
    (
        SELECT U1.NumTel
        FROM CHIAMATA C, UTENTE U1, UTENTE U2
        WHERE U1.NumTel=C.NumTelChiamante AND U2.NumTel=C.NumTelChiamato
            AND U1.NumTel<>U2.NumTel
            AND U1.Citta<>U2.Citta
    )

--1.B
SELECT U.NumTel, (ChiamateFatte# + ChiamateRicevute#) AS Totchiamate, (DurataTotFatte+ DurataTotRicevute) As TotDurata
FROM UTENTE U,
    (   
        SELECT NumTelChiamante AS NumTel, COUNT(*) As ChiamateFatte#, SUM(Durata) AS DurataTotFatte
        FROM CHIAMATA
        GROUP BY NumTelChiamante
    ) AS UChiamanti,
    (
        SELECT NumTelChiamato AS NumTel, COUNT(*) AS ChiamateRicevute#, SUM(Durata) AS DurataTotRicevute
        FROM CHIAMATA
        GROUP BY NumTelChiamato
    ) AS UChiamati
WHERE U.Citta IN 
    (
        SELECT Citta
        FROM UTENTE
        GROUP BY Citta
        HAVING COUNT(*)>=10000
    )
    AND U.NumTel=UChiamanti.NumTel AND U.NumTel=UChiamato.NumTel