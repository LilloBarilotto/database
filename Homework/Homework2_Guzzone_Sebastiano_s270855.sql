/*1.a
Show SSN, name and surname of every personal trainer who gave group lessons in
at least 3 different gyms located in Turin.
*/

SELECT SSN, Name, Surname
FROM TRAINER
WHERE SSN IN
	(
	SELECT SSN
	FROM GROUP_LESSON GL,
		(
		SELECT CodG
		FROM GYM
		WHERE City="Turin"
		) G
	WHERE GL.CodG=G.CodG
	GROUP BY GL.SSN
	HAVING COUNT(DISTINCT GL.CodG)>=3
	)



/*1.b
For each gym in which more than 10 Karate group lessons (NameS = "Karate") have
been conducted, show the code of the gym and, separately for each trainer, the
total number of participants to the group lessons (of any specialty) given by the trainer in that gym.
*/

SELECT GL1.CodG, SSN, SUM(ParticipantsNumber) AS TotalNumber
FROM GROUP_LESSON GL1,
		(
		SELECT CodG
		FROM  GROUP_LESSON GL,
			(
			SELECT CodS
			FROM SPECIALTY
			WHERE NameS="Karate"
			) S
		WHERE GL.CodS=S.CodS
		GROUP BY CodG
		HAVING COUNT(*)>10
		) G
WHERE GL1.CodG=G.CodG
GROUP BY GL1.CodG, SSN



/*1.c
For each personal trainer who gave group lessons at every gym in his city, show
name, surname and the number of specialties for which he gave lessons.
*/

SELECT Name, Surname, COUNT(DISTINCT CodS) AS NumberSpecialties
FROM TRAINER T, GROUP_LESSON GL
WHERE T.SSN=GL.SSN
	AND T.SSN IN 
        (
        SELECT T1.SSN
        FROM TRAINER T1, GROUP_LESSON GL1, GYM G1
        WHERE T1.SSN=GL1.SSN
            AND GL1.CodG=G1.CodG
            AND G1.City=T1.City
        GROUP BY T1.SSN, T1.City
        HAVING COUNT(DISTINCT GL1.CodG)=
                (
                SELECT COUNT(*)
                FROM GYM
                WHERE GYM.City=T1.City
                )
        )
GROUP BY T.SSN, Name, Surname



/*2.a
For each user type, show the average evaluation given to movies produced by
"Marvel" (MovieStudio = "Marvel").
*/

SELECT UserType, AVG(Evaluation)
FROM USER U,
	(
	SELECT SSN, Evaluation
	FROM EVALUATION
	WHERE CodM IN
		(
		SELECT CodM
		FROM MOVIE
		WHERE MovieStudio = "Marvel"
		)
	) EV
WHERE U.SSN=EV.SSN
GROUP BY UserType



/*2.b
For each user belonging to type "Expert" who has never evaluated movies of
genre "Horror" but has evaluated at least 3 movies of genre "Comedy", show name, surname and the highest evaluation assigned to movies in language "Italian".

*/
SELECT NameU, SurnameU, MaxEv
FROM USER U,
	(
	SELECT SSN, MAX(Evaluation) AS MaxEv
	FROM EVALUATION E2, MOVIE M2
	WHERE E2.CodM=M2.CodM AND Language="Italian"
	GROUP BY SSN
	) R
WHERE UserType="Expert"
	AND U.SSN NOT IN
		(
		SELECT SSN
		FROM EVALUATION E, MOVIE M
		WHERE M.CodM=E.CodM AND M.Genre="Horror"
		)
	AND U.SSN IN
		(
		SELECT SSN
		FROM EVALUATION E1, MOVIE M1
		WHERE M1.CodM=E1.CodM AND M1.Genre="Comedy"
		GROUP BY SSN
		HAVING COUNT(DISTINCT CodM)>=3
		)
	AND U.SSN=R.SSN
