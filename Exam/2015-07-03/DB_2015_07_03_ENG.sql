--1.a
SELECT TCode, TName
FROM  TEACHER
WHERE Department="Computer Science"
    AND TCode NOT IN
        (SELECT TCode
         FROM COURSE C, LECTURE L
         WHERE C.CCode= L.CCode
               AND L.AttendingStudent# >= 0.8* C.EnrollingStudent# 
        )
    AND TCode IN
        (
	SELECT TCode
        FROM COURSE C, LECTURE L
	WHERE C.CCode=L.CCode
        )
--My choice is "Take only prof that take at least one lesson


--1.b
SELECT RoomID, COUNT(*) AS Lecture#, MAX(AttendingStudent#) as MaxStudent#
FROM CLASSROOM C, LECTURE L
WHERE Video_kit = "yes"
    AND RoomID IN
    (   SELECT RoomID
        FROM(SELECT RoomID, COUNT(DISTINCT C1.CCode) AS CounterDist
            FROM LECTURE L1, COURSE C1
            WHERE Date>="2014-01-01" AND Date<="2014-12-31"
                    AND L1.CCode=C1.CCode
            GROUP BY RoomID)
        WHERE CounterDist>=20
    )
    AND C.RoomID= L.RoomID
    AND L.Date<="2014-10-31" AND L.Date>="2014-10-01"

GROUP BY RoomID


--1.c
SELECT TCode, CCode
FROM COURSE C
WHERE TCode NOT IN
    (
        SELECT TCode
        FROM COURSE
        WHERE Topic<>"Databases"
    )
    AND TCode IN
    (
        SELECT TCode
        FROM COURSE
        WHERE Topic="Databases"
    )
    AND CCode IN
    (
        SELECT CCode
        FROM COURSE C1, LECTURE L1
        WHERE C1.TCode=C.TCode
            AND L1.CCode=c1.CCode
        GROUP BY C1.CCode
        HAVING AVG(AttendingStudent) = 
                (SELECT MAX(avgStud)
                 FROM (
                        SELECT AVG(AttendingStudent) as avgStud
                        FROM COURSE C2, LECTURE L2
                        WHERE C2.TCode=C.TCode
                            AND L2.CCode=C2.CCode
                        GROUP BY C2.CCode
                    )
                 )
    )
