-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. Subqueries in the SELECT clause
SELECT * FROM happiness_scores;

-- Average happiness score
SELECT AVG(happiness_score) FROM happiness_scores;

-- Happiness score deviation from the average
SELECT	year, 
	country, 
    happiness_score,
		(SELECT AVG(happiness_score) FROM happiness_scores) AS avg_hs,
        happiness_score - (SELECT AVG(happiness_score) FROM happiness_scores) AS diff_from_avg
FROM	happiness_scores;

-- 2. Subqueries in the FROM clause
SELECT * FROM happiness_scores;

-- Average happiness score for each country
SELECT	 country, 
		AVG(happiness_score) AS avg_hs_by_country
FROM	 happiness_scores
GROUP BY country;

/* Return a country's happiness score for the year as well as
the average happiness score for the country across years */  
-- has the subquery 
SELECT	hs.year, 
		hs.country, 
        hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	happiness_scores hs LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country;
            
-- View one country
SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	happiness_scores hs LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country
WHERE	hs.country = 'United States';
            
-- 3. Multiple subqueries

-- Return happiness scores for 2015 - 2024
SELECT DISTINCT year FROM happiness_scores;
SELECT * FROM happiness_scores_current;

SELECT year, 
	   country, 
       happiness_score 
FROM happiness_scores
UNION ALL
SELECT 2024, 
	   country, 
       ladder_score 
FROM happiness_scores_current;
            
/* Return a country's happiness score for the year as well as
the average happiness score for the country across years */
SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	(SELECT year, country, happiness_score FROM happiness_scores
		 UNION ALL
		 SELECT 2024, country, ladder_score FROM happiness_scores_current) AS hs
         LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country;
       
/* Return years where the happiness score is a whole point
greater than the country's average happiness score */
SELECT * FROM

(SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	(SELECT year, country, happiness_score FROM happiness_scores
		 UNION ALL
		 SELECT 2024, country, ladder_score FROM happiness_scores_current) AS hs
         LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country) AS hs_country_hs
        
WHERE happiness_score > avg_hs_by_country + 1;

-- 4. Subqueries in the WHERE and HAVING clauses

-- Average happiness score
SELECT AVG(happiness_score) FROM happiness_scores;

-- Above average happiness scores (WHERE)
SELECT	*
FROM	happiness_scores
WHERE	happiness_score > (SELECT AVG(happiness_score) FROM happiness_scores);

-- Above average happiness scores for each region (HAVING)
SELECT	 region, AVG(happiness_score) AS avg_hs
FROM	 happiness_scores
GROUP BY region
HAVING	 avg_hs > (SELECT AVG(happiness_score) FROM happiness_scores);

-- 5. ANY vs ALL
SELECT * FROM happiness_scores; -- 2015-2023
SELECT * FROM happiness_scores_current; -- 2024

-- Scores that are greater than ANY 2024 scores
SELECT 	COUNT(*)
FROM 	happiness_scores
WHERE	happiness_score > 
		ANY(SELECT  ladder_score
			FROM	happiness_scores_current);
            
SELECT 	COUNT(*)
FROM 	happiness_scores;

-- Scores that are greater than ALL 2024 scores
SELECT 	*
FROM 	happiness_scores
WHERE	happiness_score > 
		ALL(SELECT  ladder_score
			FROM	happiness_scores_current);

-- 6. EXISTS
SELECT * FROM happiness_scores;
SELECT * FROM inflation_rates;

/* Return happiness scores of countries
that exist in the inflation rates table */
SELECT	*
FROM 	happiness_scores h
WHERE	EXISTS (     -- the inner query is a corelated subquery and cant run by itself due to connection to outer table
		SELECT	i.country_name
        FROM	inflation_rates i
        WHERE	i.country_name = h.country);  -- to show relationship to the other table

-- Alternative to EXISTS: INNER JOIN
SELECT	*
FROM 	happiness_scores h
		INNER JOIN inflation_rates i  -- to return only columns present in both tables 
        ON h.country = i.country_name 
        AND h.year = i.year;  -- the 2 conditions to check for 'sameness' when pulling the columns
     
