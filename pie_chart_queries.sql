-- ============================================
-- PIE CHART VISUALIZATIONS
-- Dataset: samples.nyctaxi.trips
-- ============================================

-- ============================================
-- PIE CHART 1: Trip Distribution by Distance Category
-- ============================================
-- Purpose: Show percentage of trips in each distance range
-- Labels: distance_category
-- Values: trips
-- Title: "Trip Distribution by Distance"

SELECT 
  CASE 
    WHEN trip_distance < 2 THEN 'Short (< 2 mi)'
    WHEN trip_distance < 5 THEN 'Medium (2-5 mi)'
    WHEN trip_distance < 10 THEN 'Long (5-10 mi)'
    ELSE 'Very Long (10+ mi)'
  END as distance_category,
  COUNT(*) as trips
FROM samples.nyctaxi.trips
WHERE trip_distance > 0 AND trip_distance < 50
GROUP BY 1
ORDER BY trips DESC;


-- ============================================
-- PIE CHART 2: Revenue Distribution by Distance Category
-- ============================================
-- Purpose: Show which distance ranges generate most revenue
-- Labels: distance_category
-- Values: revenue
-- Title: "Revenue Distribution by Distance"

SELECT 
  CASE 
    WHEN trip_distance < 2 THEN 'Short (< 2 mi)'
    WHEN trip_distance < 5 THEN 'Medium (2-5 mi)'
    WHEN trip_distance < 10 THEN 'Long (5-10 mi)'
    ELSE 'Very Long (10+ mi)'
  END as distance_category,
  ROUND(SUM(fare_amount), 2) as revenue
FROM samples.nyctaxi.trips
WHERE trip_distance > 0 
  AND trip_distance < 50
  AND fare_amount > 0
GROUP BY 1
ORDER BY revenue DESC;


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


-- ============================================
-- PIE CHART 4: Trip Distribution by Time of Day
-- ============================================
-- Purpose: Compare morning, afternoon, evening, night trips
-- Labels: time_of_day
-- Values: trips
-- Title: "Trips by Time of Day"

SELECT 
  CASE 
    WHEN HOUR(tpep_pickup_datetime) BETWEEN 6 AND 11 THEN 'Morning (6am-11am)'
    WHEN HOUR(tpep_pickup_datetime) BETWEEN 12 AND 17 THEN 'Afternoon (12pm-5pm)'
    WHEN HOUR(tpep_pickup_datetime) BETWEEN 18 AND 22 THEN 'Evening (6pm-10pm)'
    ELSE 'Night (11pm-5am)'
  END as time_of_day,
  COUNT(*) as trips,
  ROUND(SUM(fare_amount), 2) as revenue
FROM samples.nyctaxi.trips
WHERE tpep_pickup_datetime IS NOT NULL
GROUP BY 1
ORDER BY trips DESC;


-- ============================================
-- PIE CHART 5: Top 5 Pickup Zones (Share of Total)
-- ============================================
-- Purpose: Show market share of top pickup locations
-- Labels: pickup_zip
-- Values: trips
-- Title: "Top 5 Pickup Locations"

SELECT 
  pickup_zip,
  COUNT(*) as trips,
  ROUND(SUM(fare_amount), 2) as revenue
FROM samples.nyctaxi.trips
WHERE pickup_zip IS NOT NULL
GROUP BY pickup_zip
ORDER BY trips DESC
LIMIT 5;


-- ============================================
-- PIE CHART 6: Fare Range Distribution
-- ============================================
-- Purpose: Show how fares are distributed across price ranges
-- Labels: fare_range
-- Values: trips
-- Title: "Trip Distribution by Fare Range"

SELECT 
  CASE 
    WHEN fare_amount < 10 THEN 'Low ($0-$10)'
    WHEN fare_amount < 20 THEN 'Medium ($10-$20)'
    WHEN fare_amount < 40 THEN 'High ($20-$40)'
    ELSE 'Premium ($40+)'
  END as fare_range,
  COUNT(*) as trips
FROM samples.nyctaxi.trips
WHERE fare_amount > 0 AND fare_amount < 200
GROUP BY 1
ORDER BY trips DESC;


-- ============================================
-- HOW TO CREATE PIE CHART IN DATABRICKS:
-- ============================================
-- 1. Run any query above in SQL Editor
-- 2. Click the "+" button below query results
-- 3. Select "Visualization"
-- 4. Choose "Pie" or "Donut" chart type
-- 5. Configure:
--    - Label Column: First column (distance_category, day_name, etc.)
--    - Value Column: Second column (trips, revenue)
--    - Chart Title: Use title from comments above
--    - Show Percentages: Enable
--    - Show Legend: Enable
-- 6. Click "Save"
-- 7. Name your visualization
-- 
-- TIP: Pie charts work best with 3-7 categories
-- TIP: Use "Donut" chart for modern look
-- ============================================
