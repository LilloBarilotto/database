/*
Exercise 1. Given the following relations (primary keys are underlined):
COURSE (CourseCode, CourseName, Year, Semester)
COURSE SCHEDULE (CourseCode, DayOfWeek, StartTime, EndTime, Room)
express the following queries in SQL language:
(a) Find the rooms in which none of the first-year courses has ever been given.
(b) Find the codes, the names and the total number of weekly hours of the third-year courses whose total
number of weekly hours is greater than 10 and whose schedule spans three different days of the week.
*/


--a
SELECT DISTINCT Room
FROM COURSE_SCHEDULE
WHERE Room NOT IN
  (
    SELECT Room
    FROM COURSE_SCHEDULE CS, COURSE C
    WHERE C.CourseCode=CS.CourseCode AND Year=1
  )


--b
SELECT CourseCode, CourseName, SUM(EndTime - StartTime)
FROM COURSE_SCHEDULE CS, COURSE C
WHERE Year=3, CS.CourseCode=C.CourseCode
GROUP BY CourseCode, CourseName
HAVING COUNT(*)>3 AND SUM(EndTime - StartTime)>10


/*
Exercise 2. Given the following relations (primary keys are underlined):
FLAT (FCode, Address, City, Surface)
LEASING CONTRACT (LCCode, StartDate, EndDate, PersonName, MonthlyPrice, FCode)

N.B. The Surface is expressed in square meters. For contracts that have not yet expired the EndDate is NULL.

express the following queries in SQL language:
(a) For the cities in which at least 100 contracts have been signed, find the city, the maximum monthly price,
the average monthly price, the maximum duration of the leasing contracts, the average duration of the
leasing contracts and the total number of signed contracts.
(b) Find the names of the people who have never rented any flat with a surface greater than 80 square meters.
(c) Find the names of the people who have signed more than two leasing contracts for the same flat (in different
periods).
(d) Find the codes and the addresses of flats in Turin whose monthly leasing price has always been greater than
500AC and for which more than 5 contracts have been signed.
*/

--a
SELECT City, MAX(MonthlyPrice), AVG(MonthlyPrice), MAX(IFNULL(EndDate, CURDATE())-StartDate),  AVG(IFNULL(EndDate, CURDATE())-StartDate), COUNT(*) --opp NVL(EndDate, )
FROM FLAT F, LEASING_CONTRACT LC
WHERE F.FCode=LS.FCode
GROUP BY F.City
HAVING COUNT(*)>100


--b
SELECT DISTINCT PersonName
FROM LEASING_CONTRACT
WHERE PersonName NOT IN
  (
    SELECT PersonName
    FROM LEASING_CONTRACT LC, F
    WHERE F.Surface>80 AND LC.FCode=F.FCode
  )

--c
SELECT DISTINCT PersonName
FROM LEASING_CONCTRACT
GROUP BY PersonName, FCode
HAVING COUNT(*)>2

--d
FLAT (FCode, Address, City, Surface)
LEASING CONTRACT (LCCode, StartDate, EndDate, PersonName, MonthlyPrice, FCode)

SELECT FCode, Address
FROM FLAT
WHERE FCode NOT IN
  (
    SELECT FCode
    FROM LEASING_CONTRACT
    WHERE MonthlyPrice<500 AND Address="Turin"
  )
  AND FCode IN (
    SELECT FCode
    FROM LEASING_CONTRACT
    GROUP BY FCode
    HAVING COUNT(*)>5 AND Address="Turin"
  )
  AND Address="Turin"
-- si possono tralasciare i due Address nelle nested queries

/*
Exercise 3. Given the following relations (primary keys are underlined)
PERSON (Name, Sex, Age)
PARENT (ParentName, ChildName)
express the following queries in SQL language:
(a) Find the name of each person younger than 10 years old who is an only child.
*/

SELECT DISTINCT P.Name
FROM PERSON P, PARENT PP
WHERE Age<10 AND P.Name=PP.ChildName AND NOT EXISTS
  (
   SELECT *
   FROM PARENT PP1
   WHERE PP.ParentName=PP1.ParentName
   GROUP BY PP1.ParentName
   HAVING COUNT(*)>1
  )
  AND EXISTS
  (
    SELECT *
    FROM PARENT PP1
    WHERE PP.ParentName=PP1.ParentName
    GROUP BY PP1.ParentName
    HAVING COUNT(*)=1
  )
