/*1.a
1. Given the following relational schema
USER (UID, Name, Surname, DateOfBirth, City)
VIDEO (VID, Title, Category)
VIEW (UID, VID, #Views)
Write the following query in relational algebra
a. Show name and surname of users living in Turin who have viewed only videos in
the category Entertainment.
*/

SELECT DISTINCT Name, Surname
FROM USER
WHERE UID NOT IN
        (
          SELECT VW.UID
          FROM VIDEO V, VIEW VW
          WHERE Category<>"Entertainment" AND V.VID=VW.VID
        )
    AND UID IN (
          SELECT VW.UID
          FROM VIDEO V, VIEW VW
          WHERE Category="Entertainment" AND V.VID=VW.VID
        )

/*
. Given the following relational schema
Guest (GID, Name, Surname, DateOfBirth)
HOTEL (HID, Name, City, Region, #Stars)
STAY (GID, HID, StartDate, EndDate)

Write the following queries in relational algebra
a. Show name and surname of guests born after 1990/01/01 who have stayed only in
hotels located in region Piedmont.
b. Show name and city of hotels that have never hosted clients for stays shorter than
3 days (dierence between StartDate and EndDate)

*/

--a.
SELECT Name, Surname
FROM Guest
WHERE DateOfBirth > "1990/01/01"
  AND NOT EXISTS
  (
    SELECT *
    FROM STAY S , HOTEL H
    WHERE H.Region <>"Piedmont" AND S.HID=H.HID AND Guest.GID=S.GID
  )
  AND Guest.GID IN (
    SELECT S.GID
    FROM STAY S , HOTEL H
    WHERE H.Region="Piedmont" AND S.HID=H.HID
  )

--b.
SELECT Name, City
FROM HOTEL H
WHERE H.HID NOT IN (
  SELECT DISTINCT S.HID
  FROM STAY S
  WHERE S.EndDate-S.StartDate<3
)

/*
3. Given the following relational schema
PLAYER (PID, Nickname, DateOfBirth, Country)
VIDEOGAME (VID, Name, Category)
MATCH (PID, VID, Date, #Hours)
Write the following queries in relational algebra
a. Show the nicknames of players who have played all video games belonging to
category arcade.
b. Show nickname and country of players who played, on the same date, two dierent
video games belonging to the same category.
*/


--a.
SELECT Nickname
FROM PLAYER P
WHERE P.PID IN
  (
    SELECT V.PID
    FROM VIDEOGAME V, (SELECT PID, VID
                       FROM MATCH
                       GROUP BY PID, VID
                     ) M
    WHERE V.Category="arcade" AND M.VID=V.VID
    GROUP BY V.PID
    HAVING COUNT(*)=
      (
      SELECT COUNT(*)
      FROM VIDEOGAME
      WHERE Category="arcade"
      )
  )
