SELECT
    toDate(time) AS cdate,
    COUNT(DISTINCT user_id) AS DAU
FROM
    simulator_20220820.feed_actions
WHERE 
    cdate != today()
GROUP BY
    cdate