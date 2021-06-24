--1
SELECT Conference, Edition, A.AuthorCode, Name, Surname, University, COUNT(*) AS Article#
FROM AUTHOR_PRESENTS_ARTICLE APA, AUTHOR A
WHERE A.AuthorCode=APA.AuthorCode
    AND A.AuthorCode NOT IN
        (
            SELECT AuthorCode
            FROM AUTHOR_PRESENTS_ARTICLE APA1, ARTICLE ART
            WHERE ART.Topic<>"Data Mining"
                AND APA1.ArticleCode=ART.ArticleCode
        )
GROUP BY Conference, Edition, A.AuthorCode, Name, Surname


--2.A
SELECT EditionName, APA.AuthorCode, COUNT(*) AS MaxArticle#
FROM EDITIONS_OF_CONFERENCE EOC, AUTHOR_PRESENTS_ARTICLE APA
WHERE Conference IN
    (
        SELECT Conference
        FROM EDITIONS_OF_CONFERENCE
        GROUP BY Conference
        HAVING COUNT(*)>=10
    )
    AND EOC.Conference=APA.Conference AND EOC.Edition=APA.Edition
GROUP BY APA.Conference, APA.Edition, EditionName, APA.AuthorCode
HAVING COUNT(*)= 
    (
        SELECT MAX(*)
        FROM(
            SELECT COUNT(*)
            FROM AUTHOR_PRESENTS_ARTICLE APA2
            WHERE APA2.Conference=APA.Conference AND APA2.Edition=APA.Edition
            GROUP BY AuthorCode
        )
    )


--3.A
SELECT Surname, COUNT(*) as Assignment#, AVG(Score) as Average, COUNT(DISTINCT ACode) as DifferentTeacher#
FROM STUDENT S, EVALUATION_OF_DELIVERED_ASSIGNMENT EODA
WHERE S.StudentID=EODA.StudentID
    AND S.StudentID IN
    (
        SELECT StudentID
        FROM EVALUATION_OF_DELIVERED_ASSIGNMENT
        WHERE Score>4
        GROUP BY StudentID
        HAVING COUNT(*)>2
    )

--4.A
SELECT StudentID, Surname, DegreeProgramme
FROM STUDENT
WHERE StudentID NOT IN
    (
        SELECT  StudentID
        FROM    ASSIGNMENT_TO_BE_DELIVERED ATBD, EVALUATION_OF_DELIVERED_ASSIGNMENT EODA
        WHERE   ATBD.ACode=EODA.ACode
            AND EvaluationDate>ScheduledExpirationDate
    )
    AND StudentID IN 
    (
        SELECT StudentID
        FROM EVALUATION_OF_DELIVERED_ASSIGNMENT EODA1
        WHERE Score=
            (
                SELECT MAX(Score)
                FROM EVALUATION_OF_DELIVERED_ASSIGNMENT EODA2
                WHERE EODA2.ACode=EODA1.ACode
            )
        GROUP BY StudentID
        HAVING COUNT(*) =
            (
                SELECT COUNT(*)
                FROM ASSIGNMENT_TO_BE_DELIVERED
            )
    )

--5.A
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

--6.A
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
