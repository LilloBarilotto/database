--A SLIDE_2
SELECT DISTINCT SCode
FROM SEMINAR-CALENDAR
WHERE S-SSN IN
    (
        SELECT S-SSN
        FROM EXPERTISE
        GROUP BY S-SSN
        HAVING COUNT(*)=
            (
                SELECT MAX(Counter)
                FROM(
                        SELECT COUNT(*) AS Counter
                        FROM EXPERTISE
                        GROUP BY S-SSN
                    )
            )
    )

--A SLIDE_3
SELECT TCode, CCode
FROM COURSE C, LECTURE L
WHERE TCode NOT IN
    (
        SELECT TCode
        FROM COURSE
        WHERE Topic<>"Databases"
    )
    AND C.CCode=L.CCode
GROUP BY C.TCode, C.CCode
HAVING AVG(AttendingStudents#)=
    (
        SELECT MAX(Average)
        FROM
            (
                SELECT AVG(AttendingStudents#) AS Average
                FROM LECTURE L1, COURSE C1
                WHERE L1.CCode=C1.CCode
                    AND C1.TCode=C.TCode
                GROUP BY CCode
            )
    )

--SLIDE 4
--a
SELECT Name, Surname, Date, COUNT(*) AS TotalTour#, SUM(Duration) AS TotalDuration
FROM TOUR-GUIDE TG, TYPE-OF-TOUR TOT,
    GUIDED-TOUR-CARRIED-OUT GTCO
WHERE TG.GuideCode=GTCO.GuideCode AND TOT.TourTypeCode=GTCO.TourTypeCode
    AND TG.GuideCode NOT IN
    (
        SELECT GuideCode
        FROM GUIDED-TOUR-CARRIED-OUT GTCO1, GROUP G
        WHERE G.Language="French"
            AND GTCO1.GroupCode=G.GroupCode
    )
GROUP BY TG.GuideCode, TG.Name, TG.Surname, GTCO.Date

--b
SELECT TOT.Monument
FROM GUIDED-TOUR-CARRIED-OUT GTCO,
    TYPE-OF-TOUR TOT,
    GROUP G
WHERE TOT.TourTypeCode=GTCO.TourTypeCode
    AND G.GroupCode=GTCO.GroupCode
GROUP BY TOT.Monument
HAVING COUNT(*)>=10
    AND SUM(NumberOfParticipants) =
    (SELECT MAX(SumNumber)
     FROM(
            SELECT SUM(NumberOfParticipants) AS SumNumber
            FROM GUIDED-TOUR-CARRIED-OUT GTCO1,
                TYPE-OF-TOUR TOT1,
                GROUP G1
            WHERE TOT1.TourTypeCode=GTCO1.TourTypeCode
                AND G1.GroupCode=GTCO1.GroupCode
            GROUP BY TOT1.Monument
            HAVING COUNT(*)>=10
        )   
    )

--SLide 7 TEENAGER
--a
SELECT CampName, City, ActivityCode, COUNT(*) as TeenagerSub#
FROM SUMMER-CAMP SC, SUBSCRIPTION-TO-ACTIVITY-IN-SUMMER-CAMP STAS
WHERE SC.CampCode IN
    (
        SELECT CampCode
        FROM SUBSCRIPTION-TO-ACTIVITY-IN-SUMMER-CAMP STAS1,
            ACTIVITY A1
        WHERE A1.ActivityCode=STAS1.ActivityCode
        GROUP BY CampCode
        HAVING COUNT(DISTINCT SSN)>=15
                AND COUNT(DISTINCT Category)>=3
    )
   AND STAS.CampCode=SC.CampCode
GROUP BY  SC.CampCode, CampName, City, ActivityCode

--b
SELECT Name, Surname, BirthDate, CampName
FROM TEENAGER T, SUBSCRIPTION-TO-ACTIVITY-IN-SUMMER-CAMP STAS, SUMMER-CAMP SC
WHERE BirthDate<"2005/01/01"
    AND SSN IN
    (
        SELECT SSN
        FROM SUBSCRIPTION-TO-ACTIVITY-IN-SUMMER-CAMP
        GROUP BY SSN
        HAVING COUNT(DISTINCT CampCode)>=5
    )
    AND T.SSN=STAS.SSN AND SC.CampCode=STAS.CampCode
GROUP BY T.SSN, T.Name, T.Surname, T.BirthDate, SC.CampCode, SC.CampName
HAVING COUNT(DISTINCT ActivityCode)= --maybe not distinct but only count(*)
    (SELECT COUNT(DISTINCT ActivityCode)
     FROM SUBSCRIPTION-TO-ACTIVITY-IN-SUMMER-CAMP STAS1
     WHERE STAS1.CampCode=SC.CampCode
     )
