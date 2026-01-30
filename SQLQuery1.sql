-- 1.1 Total Collisions Summary
SELECT 
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    SUM(is_fatal) AS fatal_count,
    SUM(is_serious) AS serious_count,
    SUM(is_slight) AS slight_count,
    CAST(AVG(is_fatal_or_serious *100.0) as DECIMAL(10,2)) AS fatal_serious_rate_pct,
    CAST(AVG(is_fatal*100.0) as DECIMAL(10,2)) AS fatal_rate_pct,
    CAST(AVG(is_serious * 100.0) AS DECIMAL(10,2)) AS serious_rate_pct,
    CAST(AVG(is_slight * 100.0) AS DECIMAL(10,2)) AS slight_rate_pct
FROM collisions2;

-- 1.2 Collisions by Severity (Using Binary Flags)
SELECT 
    collision_severity,
    COUNT(*) AS count,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM collisions2) as DECIMAL(10,2)) AS percentage
FROM collisions2
GROUP BY collision_severity
ORDER BY count DESC;

-- 1.3 Summary Statistics for Numeric Columns
SELECT 
    CAST(AVG(number_of_vehicles *1.0) AS DECIMAL(10,2)) AS avg_vehicles,
    CAST(AVG(number_of_casualties *1.0) AS DECIMAL(10,2) ) AS avg_casualties,
    MIN(number_of_vehicles ) AS min_vehicles,
    MAX(number_of_vehicles ) AS max_vehicles,
    MIN(number_of_casualties) AS min_casualties,
    MAX(number_of_casualties) AS max_casualties
FROM collisions2;


