/*
Return Retention Rate by cohorts for each day in a certain distance (here for last 10 days).
Usually using for retention heatmaps.
*/

/* Return all activities for last 10 days */
WITH activities AS (
    SELECT time, user_id FROM simulator_20220820.feed_actions
    WHERE time >= today() - 10
),
/* Return users and their first appearance date */
new_users AS (
    SELECT user_id, min(toDate(time)) AS start_day
    FROM activities
    GROUP BY user_id
    ORDER BY user_id, start_day
),
/* Return users and their period number. 
Period number indicates, if a user was active after n days after his first visit */
user_activities AS (
    SELECT user_id, (toDate(time) - nu.start_day) as period_number
    FROM activities a
    LEFT JOIN new_users nu
    USING user_id
    GROUP BY user_id, period_number
    HAVING period_number <= 10
    ORDER BY user_id, period_number
),
/* Return, how many users we have each day in total */
cohort_size AS (
    SELECT start_day, count(*) as num_users
    FROM new_users nu
    GROUP BY start_day
    ORDER BY start_day
),
/* Return start activity day, period number and how many users were active that day */
retention_table AS (
    SELECT 
        nu.start_day as start_day,
        ua.period_number as period_number,
        count(user_id) as num_users
    FROM 
        user_activities ua
    LEFT JOIN 
        new_users nu 
    USING 
        user_id
    GROUP BY 
        nu.start_day, ua.period_number
)

SELECT 
    rt.start_day, 
    cs.num_users as total_users,
    rt.period_number as period_number,
    rt.num_users as users_retained,
    users_retained / total_users as retention_percent
FROM 
    retention_table rt
LEFT JOIN 
    cohort_size cs 
USING 
    start_day
WHERE 
    rt.start_day IS NOT NULL
ORDER BY 
    rt.start_day, rt.period_number
