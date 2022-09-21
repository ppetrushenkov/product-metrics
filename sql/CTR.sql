SELECT
    toDate(time) as cdate,
    countIf(action='like') / countIf(action='view') as ctr
FROM
    simulator_20220820.feed_actions
WHERE
    cdate >= today() - 30
GROUP BY
    cdate