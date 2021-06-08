//magazine (MId, MName, Publisher)
//article (AId, Title, Topic, MId)




//(a) Find the names of the magazines that have published at least one article about motorcycles.
SELECT DISTINCT MName
FROM magazine M, article A
WHERE M.MId==A.MId AND Topic="motorcycles";

SELECT DISTINCT MName
FROM MAGAZINE
WHERE MId IN
    (
    SELECT MId
    FROM article
    WHERE Topic="motorcycles";
    )

//(b) Find the names of the magazines that have never published any article about motorcycles.
SELECT DISTINCT MName
FROM magazine M
WHERE MId NOT IN (
  SELECT MId
  FROM article
  WHERE Topic="motorcycles";
)

//(c) Find the names of the magazines that have only ever published articles about motorcycles.
SELECT DISTINCT MName
FROM magazine M
WHERE Mid NOT IN (
    SELECT MId
    FROM article
    WHERE Topic<>"motorcycles";
  )AND Mid IN (
  SELECT MId
  FROM article
  WHERE Topic="motorcycles";
)

// (d) Find the names of the magazines that publish articles about motorcycles or cars.
SELECT DISTINCT MName
FROM magazine M, article A
WHERE M.MId=A.MId AND (Topic="motorcycles" OR Topic="cars")

SELECT DISTINCT MName
FROM magazine
WHERE MId IN (
    SELECT Mid
    FROM article
    WHERE Topic="motorcycles" OR Topic="cars"
  )

//(e) Find the names of the magazines that publish both articles about motorcycles and articles about cars.
SELECT DISTINCT MName
FROM magazine
WHERE MId IN (
    SELECT Mid
    FROM article
    WHERE Topic="motorcycles"
  ) AND MId IN (
    SELECT Mid
    FROM article
    WHERE Topic="casrs"
  )

// (f) Find the names of the magazines that have published at least two articles about motorcycles.
SELECT DISTINCT MName
FROM magazine
WHERE Mid IN (
    SELECT MId
    FROM articles
    WHERE Topic="motorcycles"
    GROUP BY Mid
    HAVING COUNT(*)>=2
)

//(g) Find the names of the magazines that have published only one article about motorcycles (i.e., they may
// have published any number of articles about other topics).
SELECT DISTINCT MName
FROM magazine
WHERE Mid IN (
    SELECT MId
    FROM articles
    WHERE Topic="motorcycles"
    GROUP BY Mid
    HAVING COUNT(*)=1
)
