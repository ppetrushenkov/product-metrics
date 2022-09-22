# **Product metrics**

## **Info:**
This repository contains different metrics, that are commonly used in analytics. This metrics allows to understand the data, find out, how many users we have each day, how many users retained in out app, how much time user spends in our app and so on.

The metrics are written in SQL using Clickhouse languange. The metrics are located in "sql" folder. The code to plot graphs will be in `user_metrics.ipynb` file.

## **Metrics:**
* DAU / WAU / MAU
* Stickiness
* Retention Rate / Cohort Retention Rate
* User turnover (New / Retained / Gone users)
* CTR (Click-through rate)
* Time in app

## **What our data is** (shown only thoose columns that we'll need):
### Data types:
| Column     | Dtype      |   Description   |
|------------|------------|-----------------|
|    time    | datetime64 |     Time [ns]   |        
|   user_id  |   uint32   | ID for each user|
|   post_id  |   uint32   | ID for each post|
|   action   |   object   |   like / view   |

### Data sample:
|   |                time | user_id | action |
|--:|--------------------:|--------:|--------|
| 0 | 2022-07-14 20:40:27 |  115269 |   like |
| 1 | 2022-07-14 20:40:27 |  122097 |   view |
| 2 | 2022-07-14 20:40:27 |  132354 |   view |
| 3 | 2022-07-14 20:40:27 |  134989 |   view |
| 4 | 2022-07-14 20:40:27 |  135083 |   view |


## **Examples**
----------------------------------------------------------------------
## 1. DAU / WAU / MAU:
DAU / WAU / MAU stands for Daily / Weekly / Monthly Active Users. This metric shows how many unique users we have each Day / Week / Month. Calculated as the number of unique users grouped by Day/Week/Month.

<img src="https://github.com/ppetrushenkov/product_metrics/pics/active_users.png" title="ActiveUsers" height="256" width="768"/>


## 2. Stickiness:
Stickiness shows, how offen user interacts with our app. This is the measure of how likely users are to stick with our app. Calculated as the rolling Daily Active Users number divided by rolling Montly Active Users number. Roughly speeking the ratio of DAU to MAU shows, how many montly users uses our app daily.

<img height="440" src="https://github.com/ppetrushenkov/product_metrics/pics/stickiness.png" title="Stickiness" width="768"/>

## 3. Retention rate:
The retention rate shows, how many users stayed with us. To calculate the retention rate, first of all we filter out only thoose users, who came to the application for the first time of a certain day. Then we calculate how many of thoose users are returned in our app for each following day. For example we can calculate, how many users stayed with us, if we want to check specific day (some kind of advertising campaign, for example).

<img height="480" src="https://github.com/ppetrushenkov/product_metrics/pics/retention.png" title="RetentionRate" width="768"/>

## 4. Cohort Retention rate:
The retention rate, calculated for a specified day can't say much. Sometimes we want to see, what retention rate we have for each of a few days in general. To do this we can calculate retention rate for different cohorts (days). Heatmap and lineplot allows you to track, what metric we have for each day and find out, what are general for our metric or we have some different results on any given day.


<img height="440" src="https://github.com/ppetrushenkov/product_metrics/pics/cohort_retention_heatmap.png" title="CohortRetentionHeatmap" width="768"/>
<img height="440" src="https://github.com/ppetrushenkov/product_metrics/pics/cohort_retention_line.png" title="CohortRetentionLine" width="768"/>

## 5. User turnover (New / Retained / Gone users)
The turnover metric shows, how many new, retained and gone users we have. This metric is calculated for each week for better visibility. To see how this metric is calculated, you can look at the `WeeklyTurnover.sql` file.

<img height="440" src="https://github.com/ppetrushenkov/product_metrics/pics/turnover.png" title="WeeklyTurnover" width="768"/>

## 6. CTR (Click-through rate)
Click-through Rate (CTR) is the metric, that shows how many clicks we have in relation to views of some post or button etc. This metric commonly used to measure the success of some advertising campaign to find out if we got a better click to view ratio. Here CTR is calculated as the ratio of the number of likes to the number of views, grouped by day.

<img height="440" src="https://github.com/ppetrushenkov/product_metrics/pics/ctr.png" title="CTR" width="768"/>

## 7. Time in app
Time in app is the metric, that shows, how much time users spends in our app in general. To calculate this metric we calculate the difference between user actions, then sum it up by each user and return the average time for each day. If the difference is greater some threshold (for example I've used threshold 5 minutes as 5 * 60 = 300 seconds), this means the user didn't use the app and we can skip this value. For more info check `TimeInApp.sql` file.

<img height="440" src="https://github.com/ppetrushenkov/product_metrics/pics/time_in_app.png" title="TimeInApp" width="768"/>