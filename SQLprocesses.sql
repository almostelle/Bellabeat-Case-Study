SELECT Id, COUNT(Id) as number_of_activedays, SUM(SedentaryMinutes) as sum_of_sedentaryminutes, SUM(LightlyActiveMinutes) as sum_of_lightminutes, SUM(FairlyActiveMinutes) as sum_of_fairlyminutes, SUM(VeryActiveMinutes) as sum_of_veryminutes, SUM(LightActiveDistance) as sum_of_lightdistance, SUM(ModeratelyActiveDistance) as sum_of_moderatedistance, SUM(VeryActiveDistance) as sum_of_verydistance
FROM `bellabeat-case-study-384718.DailyActivity.daily_intensities` 
GROUP BY Id 
ORDER BY number_of_activedays 
LIMIT 1000

SELECT id,ActivityDate, CAST((ActivityDate) AS STRING FORMAT "DAY") AS date_to_day 
FROM `bellabeat-case-study-384718.DailyActivity.daily_activity`

/*Creates a table the combines daily activity records, weight records, and sleep records*/
CREATE TABLE DailyActivity.joined_activity_weight_sleep AS
SELECT daily_Activity.Id,CAST(daily_sleep_2.Id AS INTEGER) AS ID_sleep,weight_merged.Id AS Id_weight, daily_activity.ActivityDate, SleepDay, weight_merged.ActivityDate AS ActivityDate_weight, TotalSleepRecords, TotalDistance, TrackerDistance, LoggedActivitiesDistance, VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance TotalTimeInBed, SedentaryMinutes, FairlyActiveMinutes, LightlyActiveMinutes, VeryActiveMinutes, WeightKg, WeightPounds, Fat, BMI , Calories
FROM(DailyActivity.weight_merged
  FULL OUTER JOIN DailyActivity.daily_activity 
  ON weight_merged.ActivityDate = daily_activity.ActivityDate AND weight_merged.Id = daily_activity.Id)
FULL OUTER JOIN DailyActivity.daily_sleep_2 
ON daily_sleep_2.SleepDay = daily_activity.ActivityDate AND daily_sleep_2.Id = daily_activity.Id

/* Create table that returns Ids, logged days, count of sleep / weight records, and the percentage of those records vs. the users logged days */
CREATE TABLE DailyActivity.counts_sums_activity AS
SELECT Id,SumDistance, logged_days,without_sleep_records, with_sleep_records, without_weight_records, with_weight_records, without_cal_records, with_calorie_records, sum_of_sedentaryminutes, sum_of_lightminutes, sum_of_veryminutes, (with_sleep_records/logged_days)*100 AS perc_sleep, (with_weight_records/logged_days)*100 AS perc_weight, (with_calorie_records/logged_days)*100 AS perc_calories 
FROM 
/* Calculates the number of logged days of the user from ActivityDate; Counts days when user did not record sleep data or weight data; Sums active minutes by category*/
  (SELECT Id, 
  SUM(TotalDistance) AS SumDistance, 
  COUNT(Id) as logged_days, 
  COUNT(CASE WHEN SleepDay IS NULL THEN 1 ELSE NULL END) AS without_sleep_records,
  COUNT(CASE WHEN SleepDay IS NOT NULL THEN 1 ELSE NULL END) AS with_sleep_records,
  COUNT(CASE WHEN ActivityDate_weight IS NULL THEN 1 ELSE NULL END) AS without_weight_records,
  COUNT(CASE WHEN ActivityDate_weight IS NOT NULL THEN 1 ELSE NULL END) AS 
with_weight_records,
  COUNT(CASE WHEN ActivityDate IS NULL THEN 1 ELSE NULL END) AS without_cal_records,
  COUNT(CASE WHEN ActivityDate IS NOT NULL THEN 1 ELSE NULL END) AS with_calorie_records,
  SUM(SedentaryMinutes) as sum_of_sedentaryminutes,
  SUM(LightlyActiveMinutes) as sum_of_lightminutes, 
  SUM(FairlyActiveMinutes) as sum_of_fairlyminutes, 
  SUM(VeryActiveMinutes) as sum_of_veryminutes, 
  FROM DailyActivity.joined_activity_weight_sleep
  GROUP BY Id
  ORDER BY logged_days)

/* Creates table that separates and sums steps by the time of day and groups by Id
CREATE TABLE DailyActivity.steps AS */
SELECT Id, SUM(Steps) as total_steps,COUNT(DISTINCT(ActivityDate)) AS days_logged,
SUM(CASE WHEN time_of_day = 'Morning' THEN Steps ELSE 0 END) AS steps_morning,
SUM(CASE WHEN time_of_day = 'Midday' THEN Steps ELSE 0 END) AS steps_midday,
SUM(CASE WHEN time_of_day = 'Night' THEN Steps ELSE 0 END) AS steps_night,
SUM(CASE WHEN time_of_day = 'LateNight' THEN Steps ELSE 0 END) AS steps_latenight,
FROM
(SELECT Id, ActivityDate,Steps,
CASE
WHEN day_interval BETWEEN '06:00:00' AND '12:00:00' THEN 'Morning'
  WHEN day_interval BETWEEN '12:00:01' AND '18:00:00' THEN 'Midday'
  WHEN day_interval BETWEEN '18:00:01' AND '22:00:00' THEN 'Night'
  ELSE 'LateNight' END AS time_of_day
FROM(
SELECT Id, CAST((ActivityMinute) AS DATE) AS ActivityDate,Steps, TIME(TIMESTAMP (ActivityMinute)) AS day_interval
FROM DailyActivity.minute_steps))
GROUP BY Id

