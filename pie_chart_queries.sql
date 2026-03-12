-- ============================================
-- PIE CHART 3: Trip Distribution by Day of Week
-- ============================================
-- Purpose: Show which days have most trips
-- Labels: day_name
-- Values: trips
-- Title: "Trips by Day of Week"

SELECT 
  CASE DAYOFWEEK(tpep_pickup_datetime)
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
  END as day_name,
  COUNT(*) as trips
FROM samples.nyctaxi.trips
WHERE tpep_pickup_datetime IS NOT NULL
GROUP BY DAYOFWEEK(tpep_pickup_datetime), 1
ORDER BY DAYOFWEEK(tpep_pickup_datetime);