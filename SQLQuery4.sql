-- ===== SECTION 4: ROAD CONDITIONS & ENVIRONMENTAL FACTORS
-- ===== 4.1: Collisions by Road Type =====
SELECT 
    road_type,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    
    CAST(AVG(CAST(number_of_vehicles AS FLOAT)) AS DECIMAL(10,2)) AS avg_vehicles,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties
FROM collisions2
WHERE road_type IS NOT NULL
GROUP BY road_type
ORDER BY fatal_serious_rate_pct DESC;

-- ===== 4.2: Collisions by Speed Limit =====
SELECT 
    speed_limit,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_vehicles AS FLOAT)) AS DECIMAL(10,2)) AS avg_vehicles,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties
FROM collisions2
WHERE speed_limit IS NOT NULL
GROUP BY speed_limit
ORDER BY speed_limit;

-- ===== 4.3: Collisions by Weather Conditions =====
SELECT 
    weather_conditions,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_vehicles AS FLOAT)) AS DECIMAL(10,2)) AS avg_vehicles,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties
FROM collisions2
WHERE weather_conditions IS NOT NULL
GROUP BY weather_conditions
ORDER BY total_collisions DESC;

-- ===== 4.4: Collisions by Road Surface Conditions =====
SELECT 
    road_surface_conditions,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_vehicles AS FLOAT)) AS DECIMAL(10,2)) AS avg_vehicles,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties

FROM collisions2
WHERE road_surface_conditions IS NOT NULL
GROUP BY road_surface_conditions
ORDER BY  total_collisions DESC;

-- ===== 4.5: Collisions by Light Conditions =====
SELECT 
    light_conditions,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_vehicles AS FLOAT)) AS DECIMAL(10,2)) AS avg_vehicles,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties

FROM collisions2
WHERE light_conditions IS NOT NULL
GROUP BY light_conditions
ORDER BY total_collisions DESC;

-- ===== 4.6: Collisions by Junction Detail =====
SELECT 
    junction_detail,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_vehicles AS FLOAT)) AS DECIMAL(10,2)) AS avg_vehicles,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties

FROM collisions2
WHERE junction_detail IS NOT NULL
GROUP BY junction_detail
ORDER BY total_collisions DESC;

-- ===== 4.7: Collisions by First Road Class =====
SELECT 
    first_road_class,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_vehicles AS FLOAT)) AS DECIMAL(10,2)) AS avg_vehicles,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties

FROM collisions2
WHERE first_road_class IS NOT NULL
GROUP BY first_road_class
ORDER BY total_collisions DESC;
