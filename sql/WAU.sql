SELECT
    toMonday(time) AS cdate,
    COUNT(DISTINCT user_id) AS WAU
FROM
    simulator_20220820.feed_actions
WHERE 
    cdate != toMonday(today())
GROUP BY
    cdate