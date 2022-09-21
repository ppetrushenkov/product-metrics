/* Monthly Retention Rate */

WITH action_table as ( -- Contains unique users for the day 30 days ago and the day of their activity
    SELECT 
        DISTINCT user_id,     -- get unique users
        toDate(time) as cdate -- get their appearance date
    FROM 
        simulator_20220820.feed_actions
    WHERE user_id IN (
        SELECT user_id
        FROM simulator_20220820.feed_actions
        GROUP BY user_id
        HAVING MIN(toDate(time)) = today() - 30
    )
),
retention_table as (
    SELECT
        cdate,
        count(user_id) as retention -- without 'distinct' as we did it before
    FROM action_table
    WHERE cdate != today()
    GROUP BY cdate
),
(
    SELECT groupArray(retention)[1] -- Pick first value from the array. Also it can be just 'MAX(retention)'
    FROM retention_table
) as first_retention


SELECT 
    cdate,
    retention,
    retention * 100 / first_retention as pct_retention
FROM 
    retention_table
