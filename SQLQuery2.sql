-- ===================================================================
-- 2. TIME-BASED ANALYSIS QUERIES
-- ===================================================================

-- 2.1 Collisions by Month
SELECT 
    month,
    DATENAME(MONTH, date) AS month_name,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(AVG(is_fatal_or_serious *100.0) AS DECIMAL(10,2)) AS fatal_serious_rate_pct
FROM collisions2
GROUP BY month, DATENAME(MONTH, date)
ORDER BY month;

-- 2.3 Weekly Pattern (Day of Week + Hour)
SELECT 
    day_of_week,
    hour,
    COUNT(*) AS total_collisions,
    AVG(is_fatal_or_serious*100.0) AS fatal_serious_rate_pct
FROM collisions2
WHERE hour IS NOT NULL
GROUP BY day_of_week, hour
ORDER BY 
    CASE day_of_week
        WHEN 'Monday' THEN 1 WHEN 'Tuesday' THEN 2 WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4 WHEN 'Friday' THEN 5 WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END,
    hour;



-- 2.4 Weekend vs Weekday Comparison
SELECT 
    weekend,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    cast(AVG(is_fatal_or_serious*100.0) as decimal(10,2)) AS fatal_serious_rate_pct,
    cast(AVG(number_of_vehicles*1.0) as decimal(10,2)) AS avg_vehicles,
    cast(AVG(number_of_casualties*1.0) as decimal(10,2)) AS avg_casualties
FROM collisions2
GROUP BY weekend;

-- 2.5 Rush Hour vs Normal Hours
SELECT 
    rush_hour,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    cast(AVG(is_fatal_or_serious*100.0) as decimal(10,2)) AS fatal_serious_rate_pct
FROM collisions2
GROUP BY rush_hour;


-- ===== 2.2: Collisions by Time of day =====
SELECT
    time_of_day,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    cast(AVG(is_fatal_or_serious*100.0) as decimal(10,2)) AS fatal_serious_rate_pct,
    cast(AVG(number_of_vehicles*1.0) as decimal(10,2)) AS avg_vehicles,
    cast(AVG(number_of_casualties*1.0) as decimal(10,2)) AS avg_casualties
    FROM collisions2
    GROUP BY time_of_day
    ORDER BY total_collisions desc;

--Collisions by Season
SELECT
    season,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    cast(AVG(number_of_vehicles*1.0) as decimal(10,2)) AS avg_vehicles,
    cast(AVG(number_of_casualties*1.0) as decimal(10,2)) AS avg_casualties,
    cast(avg(is_fatal_or_serious*100.0) as decimal(10,2)) as fatal_serious_rate_perc
    FROM collisions2
    GROUP BY season
    ORDER BY total_collisions desc;

    -- 9.3 Monthly Trends with Severity Breakdown
SELECT 
    month,
    collision_severity,
    COUNT(*) AS count,
    avg(is_fatal_or_serious*100.0) as fatal_serious_rate_perc,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY month) AS percentage_of_month
FROM collisions2
WHERE month IS NOT NULL
GROUP BY month, collision_severity
ORDER BY month, 
    CASE collision_severity
        WHEN 'Fatal' THEN 1
        WHEN 'Serious' THEN 2
        WHEN 'Slight' THEN 3
    END;




