-- ===================================================================
-- 10. AGGREGATE VIEWS FOR POWER BI / DASHBOARDS
-- ===================================================================

-- 10.1 Dashboard Summary View
CREATE VIEW vw_collision_summary AS
SELECT 
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS total_fatal_serious,
    SUM(is_fatal) AS total_fatal,
    AVG(is_fatal_or_serious*100.0) AS overall_fatal_serious_rate_pct,
    AVG(number_of_vehicles*1.0) AS avg_vehicles_per_collision,
    AVG(number_of_casualties*1.0) AS avg_casualties_per_collision
FROM collisions2;

-- 10.2 Severity Breakdown by Multiple Dimensions (for Power BI Matrix)
SELECT 
    weather_conditions,
    road_type,
    urban_or_rural_area,
    collision_severity,
    COUNT(*) AS collision_count
FROM collisions2
GROUP BY weather_conditions, road_type, urban_or_rural_area, collision_severity;

-- 10.3 Key Metrics by Category (for Power BI Cards/Visuals)
SELECT 
    'Weather' AS category_type, 
    weather_conditions AS category_name,
    COUNT(*) AS total_count,
    AVG(is_fatal_or_serious*100.0) AS fatal_serious_rate_pct
FROM collisions2
GROUP BY weather_conditions
UNION ALL
SELECT 
    'Road Type' AS category_type,
    road_type AS category_name,
    COUNT(*) AS total_count,
    AVG(is_fatal_or_serious*100.0) AS fatal_serious_rate_pct
FROM collisions2
GROUP BY road_type
UNION ALL
SELECT 
    'Urban/Rural' AS category_type,
    urban_or_rural_area AS category_name,
    COUNT(*) AS total_count,
    AVG(is_fatal_or_serious*100.0) AS fatal_serious_rate_pct
FROM collisions2
GROUP BY urban_or_rural_area;
