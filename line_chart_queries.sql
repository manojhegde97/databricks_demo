-- ============================================
-- LINE CHART VISUALIZATIONS
-- Dataset: samples.nyctaxi.trips
-- ============================================

-- ============================================
-- LINE CHART 1: Daily Trip Volume
-- ============================================
-- Purpose: Show trip trends over time (daily)
-- X-axis: pickup_date
-- Y-axis: trips
-- Title: "Daily Trip Volume"
-- Line Color: #4096B5 (Blue)

SELECT 
  DATE(tpep_pickup_datetime) as pickup_date,
  COUNT(*) as trips,
  ROUND(AVG(fare_amount), 2) as avg_fare,
  ROUND(SUM(fare_amount), 2) as total_revenue
FROM samples.nyctaxi.trips
WHERE tpep_pickup_datetime IS NOT NULL
GROUP BY DATE(tpep_pickup_datetime)
ORDER BY pickup_date
LIMIT 30;


