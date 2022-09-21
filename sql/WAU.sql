select
    toMonday(time) as cdate,
    count(distinct user_id) as WAU
from
    simulator_20220820.feed_actions
WHERE 
    cdate != toMonday(today())
group by
    cdate