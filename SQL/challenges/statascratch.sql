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

-- 2. Calculate the percentage of users who are both from the US and have an 'open' status, as indicated in the fb_active_users table.
SELECT 
  ROUND(
    100.0 * COUNT(CASE WHEN status = 'open' AND country = 'USA' THEN user_id END) 
    / COUNT(user_id), 
    2
  ) AS us_active_share
FROM fb_active_users;


-- 3 Election Results -- used mutiple queries 
/*The election is conducted in a city and everyone can vote for one or more candidates, or choose not to vote at all. 
Each person has 1 vote so if they vote for multiple candidates, their vote gets equally split across these candidates. 
For example, if a person votes for 2 candidates, these candidates receive an equivalent of 0.5 vote each. 
Some voters have chosen not to vote, which explains the blank entries in the dataset.
Find out who got the most votes and won the election. Output the name of the candidate or multiple names in case of a tie.
To avoid issues with a floating-point error you can round the number of votes received by a candidate to 3 decimal places.*/

WITH vote_counts AS (
    -- Count how many candidates each voter voted for
    SELECT 
        voter,
        COUNT(candidate) AS candidate_count
    FROM voting_results
    WHERE candidate IS NOT NULL
    GROUP BY voter
),
vote_distribution AS (
    -- Assign equal vote share per candidate per voter
    SELECT 
        vr.candidate,
        vr.voter,
        1.0 / vc.candidate_count AS vote_share
    FROM voting_results vr
    JOIN vote_counts vc
      ON vr.voter = vc.voter
    WHERE vr.candidate IS NOT NULL
),
candidate_votes AS (
    -- Total vote per candidate, rounded to 3 decimals
    SELECT 
        candidate,
        ROUND(SUM(vote_share), 3) AS total_votes
    FROM vote_distribution
    GROUP BY candidate
),
max_vote_cte AS (
    SELECT MAX(total_votes) AS max_votes FROM candidate_votes
)
-- Select the candidate(s) who got the max vote
SELECT candidate
FROM candidate_votes
WHERE total_votes = (SELECT max_votes FROM max_vote_cte)
ORDER BY candidate;
