SELECT 
    DISTINCT cdate,
    DAU / MAU * 100 AS stickiness
FROM
    (SELECT 
        toDate(time) AS cdate,
        -- Window func, that counts unique users FROM 30 days ago TO today
        COUNT(DISTINCT user_id) OVER (ORDER BY cdate 
                                      RANGE BETWEEN 30 PRECEDING AND CURRENT ROW) AS MAU,
        -- Window func, that counts unique users BY our date column (for each day)
        COUNT(DISTINCT user_id) OVER (PARTITION BY cdate) AS DAU
        
    FROM 
        simulator_20220820.feed_actions
    WHERE
        cdate != today())