-- ============================================
-- BAR CHART : Trips by Distance Category
-- ============================================
-- Purpose: Show distribution of trips by distance ranges
-- X-axis: distance_category
-- Y-axis: trips
-- Title: "Trips by Distance Category"
-- Color: #4096B5 (Blue)

SELECT 
  CASE 
    WHEN trip_distance < 2 THEN 'Short (< 2 mi)'
    WHEN trip_distance < 5 THEN 'Medium (2-5 mi)'
    WHEN trip_distance < 10 THEN 'Long (5-10 mi)'
    ELSE 'Very Long (10+ mi)'
  END as distance_category,
  COUNT(*) as trips,
  ROUND(AVG(fare_amount), 2) as avg_fare
FROM samples.nyctaxi.trips
WHERE trip_distance > 0 AND trip_distance < 50
GROUP BY 1
ORDER BY trips DESC;