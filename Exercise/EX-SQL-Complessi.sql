
--Exercise no. 1
SELECT AuthorCode, Surname, University, Conference, Edition, COUNT(*)
FROM AUTHOR A, AUTHOR_PRESENTS_ARTICLE APA
WHERE APA.AuthorCode NOT IN
            (   SELECT AuthorCode
                FROM AUTHOR_PRESENTS_ARTICLE APA1, ARTICLE A1
                WHERE APA1.ArticleCode=A1.ArticleCode
                    AND A1.Topic<>'Data Mining'
            )
        AND APA.AuthorCode=A.AuthorCode
GROUP BY A.AuthorCode, A.Surname, A.University, APA.Conference, APA.Edition


--Exercise no. 2
SELECT EditionName, AuthorCode,  
FROM EDITIONS_OF_CONFERENCE EOC, AUTHOR_PRESENTS_ARTICLE APA
WHERE EOC.Conference IN 
    (
    SELECT Conference
    FROM EDITIONS_OF_CONFERENCE
    GROUP BY Conference
    HAVING COUNT(Edition)>=10
    )
    AND EOC.Conference=APA.Conference 
    AND EOC.Edition= APA.Edition
GROUP BY EOC.Conference, EOC.Edition, EOC.EditionName, APA.AuthorCode
HAVINC COUNT(*)=
    (SELECT MAX(NumberOfArticle)
    FROM(SELECT COUNT(*) as NumberOfArticle
        FROM AUTHOR_PRESENTS_ARTICLE APA1
        WHERE APA1.Conference=APA.Conference
                AND APA1.Edition=APA.Edition
        GROUP BY APA1.Conference, APA1.Edition, APA1.AuthorCode
        )
    )


--Exercise no. 3
SELECT Surname, COUNT(*) AS AllAssignmentDelivered, AVG(Score) AS Average, COUNT(DISTINCT TeacherID) as NumberOfDifferentTeacher
FROM EVALUATION_OF_DELIVERED_ASSIGNMENT EOFDA, STUDENT S
WHERE    EOFDA.StudentID IN
            (
            SELECT StudentID
            FROM EVALUATION_OF_DELIVERED_ASSIGNMENT
            WHERE Score>4
            GROUP BY StudentID
            HAVING COUNT(*)>=3
            )
        AND EOFDA.StudentID= S.StudentID
GROUP BY EOFDA.StudentID


--Exercise no. 4
SELECT StudentID, Surname, DegreeProgramme
FROM STUDENT S
WHERE StudentID NOT IN
        (SELECT StudentID
        FROM EVALUATION_OF_DELIVERED_ASSIGNMENT EOFDA, ASSIGNMENT_TO_BE_DELIVERED ATBD
        WHERE EOFDA.ACode=ATBD.ACode
                AND DeliveryDate>ScheduledExpirationDate 
        )
    AND StudentID IN
        (SELECT StudentID
        FROM EVALUATION_OF_DELIVERED_ASSIGNMENT EOFDA1
        WHERE EOFDA1.Score=
                    (SELECT MAX(Score)
                    FROM EVALUATION_OF_DELIVERED_ASSIGNMENT EOFDA2
                    WHERE EOFDA2.ACode= EOFDA1.ACode
                    )
        GROUP BY StudentID
        HAVING COUNT(*)= (SELECT COUNT(*)
                            FROM ASSIGNMENT_TO_BE_DELIVERED)      
        )

--Exercise no. 4 another example
SELECT StudentID, Surname, DegreeProgramme
FROM STUDENT S
WHERE StudentID NOT IN
        (SELECT StudentID
        FROM EVALUATION_OF_DELIVERED_ASSIGNMENT EOFDA, ASSIGNMENT_TO_BE_DELIVERED ATBD
        WHERE EOFDA.ACode=ATBD.ACode
                AND DeliveryDate>ScheduledExpirationDate 
        )
    AND StudentID IN
        (SELECT StudentID
        FROM EVALUATION_OF_DELIVERED_ASSIGNMENT 
        WHERE (ACode, Score) IN
                    (SELECT ACode, MAX(Score)
                    FROM EVALUATION_OF_DELIVERED_ASSIGNMENT
                    GROUP BY Acode
                    )
        GROUP BY StudentID
        HAVING COUNT(*)= (SELECT COUNT(*)
                            FROM ASSIGNMENT_TO_BE_DELIVERED)      
        )


--- Exercise no. 5
SELECT DISTINCT SCode
FROM SEMINAR-CALENDAR
WHERE S-SSN IN
    (
     SELECT S-SSN
     FROM EXPERTISE
     GROUP BY S-SSN
     HAVING COUNT(*)= 
        (
         SELECT MAX(#E)
         FROM (
                SELECT COUNT(*) AS #E
                FROM EXPERTISE
                GROUP BY S-SSN
                ) 
        ) 
    )


-- eXERCISE NO. 6
SELECT C.TCode, C.CCode
FROM COURSE C, LECTURE L
WHERE C.TCode NOT IN 
    (
        SELECT TCode
        FROM COURSE
        WHERE Topic <>  'Databases'
    )
    AND C.CCode=L.CCode
GROUP BY C.TCode, L.CCode 
HAVING AVG(AttendingStudents#) =
    (
        SELECT Max(AvgStud)
        FROM(
            SELECT AVG(AttendingStudents#)
            FROM COURSE C1, LECTURE L1
            WHERE C1.TCode=C.TCode
                AND L1.CCode= C1.CCode
            GROUP BY C1.CCode
        )
    )