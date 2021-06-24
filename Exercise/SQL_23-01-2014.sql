SELECT OrganizerCod, OName
FROM ORGANIZER 
WHERE OrganizerCod IN 
    (
        SELECT OrganizerCod
        FROM CROSS_COUNTRY_RACE
        GROUP BY OrganizerCod, Category
        HAVING COUNT(DISTINCT City)>1
    )


SELECT OName
FROM   ORGANIZER
WHERE OrganizerCod IN
    (
        SELECT OrganizerCod
        FROM CROSS_COUNTRY_RACE
        WHERE Category="Under 14" AND Region="Piedmont"
    )
    AND OrganizerCod NOT IN
    (
        SELECT OrganizerCod
        FROM CROSS_COUNTRY_RACE
        WHERE Category="Under 20" AND Region="Piedmont"
    )


SELECT PName
FROM PARTICIPANT P
WHERE ParticipantCod IN
    (
        SELECT ParticipantCod
        FROM PARTICIPANT_PARTICIPATES_RACE PPR, CROSS_COUNTRY_RACE CCR 
        WHERE PPR.RaceCode=CCR.RaceCode
                AND CCR.Region=P.Region
        GROUP BY ParticipantCod
        HAVING COUNT(*)=
            (
                SELECT COUNT(*)
                FROM CROSS_COUNTRY_RACE CCR1
                WHERE CCR1.Region=P.Region
            )
    )
    AND ParticipantCod NOT IN
    (
        SELECT ParticipantCod
        FROM PARTICIPANT_PARTICIPATES_RACE
        WHERE Rank=1
    )