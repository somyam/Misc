-- Before running drop any existing views
DROP VIEW IF EXISTS q0;
DROP VIEW IF EXISTS q1i;
DROP VIEW IF EXISTS q1ii;
DROP VIEW IF EXISTS q1iii;
DROP VIEW IF EXISTS q1iv;
DROP VIEW IF EXISTS q2i;
DROP VIEW IF EXISTS q2ii;
DROP VIEW IF EXISTS q2iii;
DROP VIEW IF EXISTS q3i;
DROP VIEW IF EXISTS q3ii;
DROP VIEW IF EXISTS q3iii;
DROP VIEW IF EXISTS q4i;
DROP VIEW IF EXISTS q4ii;
DROP VIEW IF EXISTS q4iii;
DROP VIEW IF EXISTS q4iv;
DROP VIEW IF EXISTS q4v;

-- Question 0
CREATE VIEW q0(era) AS
  SELECT MAX(era)
  FROM pitching -- replace this line
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE weight > 300
  -- replace this line
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE namefirst LIKE '% %'
  ORDER BY namefirst ASC, namelast ASC
  -- replace this line
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear, AVG(height) as avgheight, COUNT(*) as count
  FROM people
  GROUP BY birthyear
  ORDER BY birthyear ASC
  -- replace this line
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT * FROM q1iii
  WHERE avgheight > 70
  -- replace this line
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT namefirst, namelast, p.playerid, yearid
  FROM people AS p
  JOIN halloffame AS h
  ON p.playerid = h.playerid
  WHERE h.inducted = "Y"
  ORDER BY yearid DESC, p.playerid ASC
  -- replace this line
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT p.namefirst, p.namelast, p.playerid, c.schoolid, h.yearid
  FROM people as p, halloffame as h, schools as s, collegeplaying as c
  WHERE p.playerid = h.playerid
  AND h.playerid = c.playerid
  AND c.schoolid = s.schoolid
  AND s.schoolstate = 'CA'
  AND h.inducted = 'Y'
  ORDER BY h.yearid DESC, s.schoolid ASC, p.playerid ASC
  -- replace this line
;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  SELECT p.playerid, namefirst, namelast, schoolid
  FROM people as p
  INNER JOIN halloffame as h
  ON p.playerid = h.playerid
  LEFT JOIN collegeplaying as c
  ON p.playerid = c.playerid
  WHERE h.inducted = 'Y'
  ORDER BY p.playerid DESC, c.schoolid
  -- replace this line
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
  SELECT p.playerid, namefirst, namelast, yearid,
  CAST(((h - h2b - h3b - hr) + 2* h2b + 3* h3b + 4* hr)/CAST(ab AS FLOAT) AS FLOAT) as slg
  FROM people as p, batting as b
  WHERE p.playerid = b.playerid
  AND ab > 50
  ORDER BY slg DESC, yearid ASC, p.playerid ASC
  LIMIT 10
  -- replace this line
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS

SELECT playerid, namefirst, namelast, lslg
  FROM
    (SELECT p.playerid, namefirst, namelast, yearid,
      CAST((SUM(h-h2b-h3b-hr) + 2* SUM(h2b) + 3*SUM(h3b) + 4*SUM(hr)) AS FLOAT) / CAST(SUM(ab) AS FLOAT) as lslg,
      SUM(ab) as summ
      FROM people as p, batting as b
      WHERE p.playerid = b.playerid
      GROUP BY p.playerid
    )
  WHERE summ > 50
  ORDER BY lslg DESC, playerid ASC
  LIMIT 10
  -- replace this line
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  SELECT namefirst, namelast,
        CAST((SUM(h-h2b-h3b-hr) + 2* SUM(h2b) + 3*SUM(h3b) + 4*SUM(hr)) AS FLOAT) / CAST(SUM(ab) AS FLOAT) as lslg,
        FROM people as p
        INNER JOIN batting as b
        ON p.playerid = b.playerid
        GROUP BY p.playerid
        HAVING SUM(ab) > 50 AND lslg >
          (SELECT CAST((SUM(h-h2b-h3b-hr) + 2* SUM(h2b) + 3*SUM(h3b) + 4*SUM(hr)) AS FLOAT) / CAST(SUM(ab) AS FLOAT) as lslg
            FROM batting as b
            WHERE b.playerid = 'mayswi01'
            GROUP BY b.playerid)
  -- replace this line
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg)
AS
  SELECT yearid, MIN(salary) as min, MAX(salary) as max, AVG(salary) as avg
  FROM salaries
  GROUP BY yearid
  ORDER BY yearid ASC
  -- replace this line
;


-- Helper table for 4ii
DROP TABLE IF EXISTS binids;
CREATE TABLE binids(binid);
INSERT INTO binids VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;
-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
  SELECT 1, 1 -- replace this line
;
