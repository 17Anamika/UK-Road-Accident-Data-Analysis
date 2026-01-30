-- ===================================================================
-- 6. RISK RATE ANALYSIS (Using Feature Engineered Columns)
-- ===================================================================

-- 6.1 High Risk Road Types (where risk rate > 30%)
SELECT 
    road_type,
    COUNT(*) AS total_collisions,
    AVG(road_type_fatal_serious_rate) * 100 AS risk_rate_pct
FROM collisions2
GROUP BY road_type
HAVING AVG(road_type_fatal_serious_rate) > 0.30
ORDER BY risk_rate_pct DESC;

-- 6.2 High Risk Weather Conditions
SELECT 
    weather_conditions,
    COUNT(*) AS total_collisions,
    AVG(weather_conditions_fatal_serious_rate) * 100 AS risk_rate_pct
FROM collisions2
GROUP BY weather_conditions
HAVING AVG(weather_conditions_fatal_serious_rate) > 0.30
ORDER BY risk_rate_pct DESC;

-- 6.3 High risk urban or rural area
SELECT 
    urban_or_rural_area,
    AVG(urban_or_rural_area_fatal_serious_rate) * 100 AS avg_urban_risk_pct,
    COUNT(*) AS total_collisions
FROM collisions2
GROUP BY urban_or_rural_area
HAVING AVG(urban_or_rural_area_fatal_serious_rate)>0.30
ORDER BY avg_urban_risk_pct

-- ===== SECTION 7: COMBINATION ANALYSIS USING RISK RATE COLUMNS =====
-- ===== 7.1: Weather + Road Surface (Using Both Risk Rate Columns) =====
SELECT 
    weather_conditions,
    road_surface_conditions,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    -- Use pre-calculated risk rates and calculate combined risk
    CAST(AVG(weather_conditions_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS weather_risk_pct,
    CAST(AVG(road_surface_conditions_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS surface_risk_pct,
    -- Combined risk (average of both)
    CAST(AVG((weather_conditions_fatal_serious_rate + road_surface_conditions_fatal_serious_rate) / 2.0) * 100 AS DECIMAL(10,2)) AS combined_risk_pct
FROM collisions2
WHERE weather_conditions IS NOT NULL 
  AND road_surface_conditions IS NOT NULL
  AND weather_conditions_fatal_serious_rate IS NOT NULL
  AND road_surface_conditions_fatal_serious_rate IS NOT NULL
GROUP BY weather_conditions, road_surface_conditions
HAVING COUNT(*) >= 50
ORDER BY combined_risk_pct DESC;

-- ===== 7.2: Road Type + Speed Limit (Using Both Risk Rate Columns) =====
SELECT 
    road_type,
    speed_limit,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    -- Use pre-calculated risk rates
    CAST(AVG(road_type_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS road_type_risk_pct,
    CAST(AVG(speed_limit_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS speed_limit_risk_pct,
    -- Combined risk
    CAST(AVG((road_type_fatal_serious_rate + speed_limit_fatal_serious_rate) / 2.0) * 100 AS DECIMAL(10,2)) AS combined_risk_pct
FROM collisions2
WHERE road_type IS NOT NULL 
  AND speed_limit IS NOT NULL
  AND road_type_fatal_serious_rate IS NOT NULL
  AND speed_limit_fatal_serious_rate IS NOT NULL
GROUP BY road_type, speed_limit
HAVING COUNT(*) >= 30
ORDER BY combined_risk_pct DESC;

-- ===== 7.3: Urban/Rural + Time of Day (Using Both Risk Rate Columns) =====
SELECT 
    urban_or_rural_area,
    time_of_day,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    -- Use pre-calculated risk rates
    CAST(AVG(urban_or_rural_area_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS urban_rural_risk_pct,
    CAST(AVG(time_of_day_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS time_of_day_risk_pct,
    -- Combined risk
    CAST(AVG((urban_or_rural_area_fatal_serious_rate + time_of_day_fatal_serious_rate) / 2.0) * 100 AS DECIMAL(10,2)) AS combined_risk_pct
FROM collisions2
WHERE urban_or_rural_area IS NOT NULL 
  AND time_of_day IS NOT NULL
  AND urban_or_rural_area_fatal_serious_rate IS NOT NULL
  AND time_of_day_fatal_serious_rate IS NOT NULL
GROUP BY urban_or_rural_area, time_of_day
HAVING COUNT(*) >= 30
ORDER BY combined_risk_pct DESC;

-- ===== 7.4: Light Conditions + Weather (Using Both Risk Rate Columns) =====
SELECT 
    light_conditions,
    weather_conditions,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    -- Use pre-calculated risk rates
    CAST(AVG(light_conditions_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS light_risk_pct,
    CAST(AVG(weather_conditions_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS weather_risk_pct,
    -- Combined risk
    CAST(AVG((light_conditions_fatal_serious_rate + weather_conditions_fatal_serious_rate) / 2.0) * 100 AS DECIMAL(10,2)) AS combined_risk_pct
FROM collisions2
WHERE light_conditions IS NOT NULL 
  AND weather_conditions IS NOT NULL
  AND light_conditions_fatal_serious_rate IS NOT NULL
  AND weather_conditions_fatal_serious_rate IS NOT NULL
GROUP BY light_conditions, weather_conditions
HAVING COUNT(*) >= 30
ORDER BY combined_risk_pct DESC;

-- ===== 7.5: Top High-Risk Combinations (Multiple Risk Factors) =====
SELECT TOP 20
    road_type,
    weather_conditions,
    light_conditions,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    -- Calculate weighted combined risk from all three factors
    CAST(AVG(
        (road_type_fatal_serious_rate + 
         weather_conditions_fatal_serious_rate + 
         light_conditions_fatal_serious_rate) / 3.0
    ) * 100 AS DECIMAL(10,2)) AS combined_risk_pct,
    -- Individual risk rates
    CAST(AVG(road_type_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS road_risk_pct,
    CAST(AVG(weather_conditions_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS weather_risk_pct,
    CAST(AVG(light_conditions_fatal_serious_rate) * 100 AS DECIMAL(10,2)) AS light_risk_pct
FROM collisions2
WHERE road_type IS NOT NULL 
  AND weather_conditions IS NOT NULL
  AND light_conditions IS NOT NULL
  AND road_type_fatal_serious_rate IS NOT NULL
  AND weather_conditions_fatal_serious_rate IS NOT NULL
  AND light_conditions_fatal_serious_rate IS NOT NULL
GROUP BY road_type, weather_conditions, light_conditions
HAVING COUNT(*) >= 20
ORDER BY combined_risk_pct DESC;




