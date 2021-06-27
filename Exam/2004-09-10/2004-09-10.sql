--1.A
SELECT NomeM
FROM MECCANICO
WHERE MatrM IN
    (
        SELECT MatrM
        FROM EFFETTUA-RIPARAZIONE ER, SA-RIPARARE SR
        WHERE ER.MatrM=SR.MatrM 
            AND TipoGuasto NOT IN
            (
                SELECT TipoGuasto
                FROM SA-RIPARARE SR1
                WHERE SR1.MatrM=SR.MatrM
            )
    );

--1.B
SELECT Targa, Data, COUNT(DISTINCT TipoGuasto) AS GuastiDiversi#
FROM EFFETTUA-RIPARAZIONE
GROUP BY Targa,Data
HAVING COUNT(DISTINCT MatrM)>=3
ORDER BY Targa ASC, Data DESC;