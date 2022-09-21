SELECT
    toStartOfMonth(time) AS cdate,
    COUNT(DISTINCT user_id) AS MAU
FROM
    simulator_20220820.feed_actions
GROUP BY
    cdate