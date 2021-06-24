--1.A
SELECT MName
FROM MAGAZINE M, ARTICLE A
WHERE M.MId=A.MId
    AND Topic="Motorcycles"
GROUP BY MId, MName;
--Sarebbe sbagliato senza group by, avrei ripetizioni dello stesso magazzino
--Anche togliendo group by e mettendo select distinct Mname sarebbe sbagliato
--non ho informazioni se MName è unique o meno

--1.B
SELECT MName
FROM MAGAZINE
WHERE MId NOT IN
    (SELECT MId
     FROM ARTICLE
     WHERE Topic="Motorcycles");


--1.C
SELECT MName
FROM MAGAZINE
WHERE MId NOT IN
    (SELECT MId
     FROM ARTICLE
     WHERE Topic<>"Motorcycles")
     AND MId IN
     (SELECT MId
     FROM ARTICLE
     WHERE Topic="Motorcycles");

--1.D
SELECT MName
FROM MAGAZINE
WHERE MId IN
     (SELECT MId
     FROM ARTICLE
     WHERE Topic="Motorcycles")
     OR MId IN
     (SELECT MId
     FROM ARTICLE
     WHERE Topic="Cars");


--1.E
SELECT MName
FROM MAGAZINE
WHERE MId IN
     (SELECT MId
     FROM ARTICLE
     WHERE Topic="Motorcycles")
     AND MId IN
     (SELECT MId
     FROM ARTICLE
     WHERE Topic="Cars");

--1.F
SELECT MName
FROM MAGAZINE M, ARTICLE A
WHERE M.MId=A.MId
    AND Topic="Motorcycles"
GROUP BY M.MId, M.MName
HAVING COUNT(*)>1;

--1.G
SELECT MName
FROM MAGAZINE M, ARTICLE A
WHERE M.MId=A.MId
    AND Topic="Motorcycles"
GROUP BY M.MId, M.MName
HAVING COUNT(*)=1;


---------------------------------
--2.A
SELECT SName
FROM SAILER
WHERE SId IN
    (
        SELECT SId 
        FROM BOOKING BK, BOAT B
        WHERE Color="Green" OR Color="Red"
            AND BK.BId=B.BId
    );

--2.B
SELECT SId, SName
FROM SAILER
WHERE SId IN
    (
        SELECT SId 
        FROM BOOKING BK, BOAT B
        WHERE Color="Green"
            AND BK.BId=B.BId
    )
    AND SId IN
    (
        SELECT SId 
        FROM BOOKING BK, BOAT B
        WHERE Color="Red"
            AND BK.BId=B.BId
    );

--2.C
SELECT SId
FROM SAILER
WHERE SId NOT IN
    (
        SELECT SId 
        FROM BOOKING BK, BOAT B
        WHERE Color="Red"
            AND BK.BId=B.BId
    );

--2.D
SELECT SId, SName
FROM SAILER
WHERE SId NOT IN
    (
        SELECT SId 
        FROM BOOKING BK, BOAT B
        WHERE Color="Red"
            AND BK.BId=B.BId
    );

--2.E
SELECT SId, SName
FROM SAILER S, BOOKING BK
WHERE S.SId=BK.SId
GROUP BY S.SId, SName
HAVING COUNT(*)>1;

--2.E
SELECT SId, SName
FROM SAILER S, BOOKING BK
WHERE S.SId=BK.SId
GROUP BY S.SId, SName
HAVING COUNT(*)>2;

-------------------------------------------
--3.A
SELECT PId, PName
FROM PILOT
WHERE PId IN
    (
        SELECT PId
        FROM CERTIFICATE C, AIRCRAFT A
        WHERE C.AId=A.AId
            AND MaximumRange>=5000
    );

--3.B
SELECT PId, PName
FROM PILOT
WHERE PId IN
    (
        SELECT PId
        FROM CERTIFICATE C, AIRCRAFT A
        WHERE C.AId=A.AId
            AND MaximumRange>=5000
        GROUP BY PId
        HAVING COUNT(*)>1
    );

--3.C
SELECT PId, PName
FROM PILOT
WHERE PId IN
    (
        SELECT PId
        FROM CERTIFICATE C, AIRCRAFT A
        WHERE C.AId=A.AId
            AND MaximumRange>=5000
        GROUP BY PId
        HAVING COUNT(*)>1
    )
    AND PId IN
    (
        SELECT PId
        FROM CERTIFICATE C, AIRCRAFT A
        WHERE C.AId=A.AId
            AND AName="Boeing"
    );