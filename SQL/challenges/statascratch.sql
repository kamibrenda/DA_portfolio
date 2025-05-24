-- statscratch queries 
-- 1. intermediate Which user flagged the most distinct videos that ended up approved by YouTube?
-- Output, in one column, their full name or names in case of a tie. 
-- In the user's full name, include a space between the first and the last name.

SELECT 
    uf.user_firstname || ' ' || uf.user_lastname AS full_name
FROM user_flags uf
JOIN flag_review fr ON uf.flag_id = fr.flag_id
WHERE fr.reviewed_outcome = 'APPROVED'
GROUP BY uf.user_firstname, uf.user_lastname
HAVING COUNT(DISTINCT uf.video_id) = (
    SELECT MAX(flagged_count)
    FROM (
        SELECT COUNT(DISTINCT uf2.video_id) AS flagged_count
        FROM user_flags uf2
        JOIN flag_review fr2 ON uf2.flag_id = fr2.flag_id
        WHERE fr2.reviewed_outcome = 'APPROVED'
        GROUP BY uf2.user_firstname, uf2.user_lastname
    ) AS counts
);