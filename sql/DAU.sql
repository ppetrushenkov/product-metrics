select
    toDate(time) as cdate,
    count(distinct user_id) as DAU
from
    simulator_20220820.feed_actions
WHERE 
    cdate != today()
group by
    cdate