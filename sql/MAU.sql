select
    toStartOfMonth(time) as cdate,
    count(distinct user_id) as MAU
from
    simulator_20220820.feed_actions
group by
    cdate