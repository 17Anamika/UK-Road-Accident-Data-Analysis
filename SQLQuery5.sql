-- ===== 5.1: Collisions by Number of Vehicles =====
SELECT 
    number_of_vehicles,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties
FROM collisions2
WHERE number_of_vehicles IS NOT NULL
GROUP BY number_of_vehicles
ORDER BY number_of_vehicles;

-- ===== 5.2: Collisions by Number of Casualties =====
SELECT 
    number_of_casualties,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_vehicles AS FLOAT)) AS DECIMAL(10,2)) AS avg_vehicles
FROM collisions2
WHERE number_of_casualties IS NOT NULL
GROUP BY number_of_casualties
ORDER BY number_of_casualties;

-- ===== 5.3: High Severity Collisions (Fatal/Serious) =====
SELECT TOP 20
    collision_index,
    date,
    time,
    police_force,
    road_type,
    speed_limit,
    weather_conditions,
    light_conditions,
    number_of_vehicles,
    number_of_casualties,
    urban_or_rural_area,
    latitude,
    longitude,
    is_fatal,
    is_serious
FROM collisions2
WHERE is_fatal_or_serious = 1
ORDER BY 
    CASE WHEN is_fatal = 1 THEN 1 ELSE 2 END,  -- Fatal first
    date DESC;

-- ===== 5.4: Multi-Vehicle Collisions Analysis =====
WITH categorized AS (
    SELECT
        CASE
            WHEN number_of_vehicles = 1 THEN 'Single Vehicle'
            WHEN number_of_vehicles = 2 THEN 'Two Vehicles'
            WHEN number_of_vehicles >= 3 THEN 'Multiple Vehicles (3+)'
            ELSE 'Unknown'
        END AS vehicle_category,
        is_fatal_or_serious,
        number_of_casualties
    FROM collisions2
    WHERE number_of_vehicles IS NOT NULL
)
SELECT
    vehicle_category,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(SUM(is_fatal_or_serious) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(CAST(number_of_casualties AS FLOAT)) AS DECIMAL(10,2)) AS avg_casualties
FROM categorized
GROUP BY vehicle_category
ORDER BY
CASE vehicle_category
    WHEN 'Multiple Vehicles (3+)' THEN 1
    WHEN 'Two Vehicles' THEN 2
    WHEN 'Single Vehicle' THEN 3
    ELSE 4
END;