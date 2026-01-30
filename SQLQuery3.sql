-- ===== SECTION 3: GEOGRAPHIC ANALYSIS =====



-- ===== 3.1: Collisions by Police Force =====
SELECT 
    police_force,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(AVG(is_fatal_or_serious *100.0) as DECIMAL(10,2)) AS fatal_serious_rate_pct,
    SUM(is_fatal) AS fatal_count,
    cast(AVG(number_of_casualties*1.0) as decimal(10,2)) AS avg_casualties
FROM collisions2
WHERE police_force IS NOT NULL
GROUP BY police_force
ORDER BY total_collisions DESC;

-- ===== 3.2: Collisions by Local Authority =====
SELECT 
    local_authority_ons_district,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(AVG(is_fatal_or_serious *100.0) as DECIMAL(10,2)) AS fatal_serious_rate_pct,
    SUM(is_fatal) AS fatal_count
FROM collisions2
WHERE local_authority_ons_district IS NOT NULL
GROUP BY local_authority_ons_district
ORDER BY total_collisions DESC;

-- ===== 3.3: Collisions by Urban/Rural Area =====
SELECT 
    urban_or_rural_area,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(AVG(is_fatal_or_serious *100.0) as DECIMAL(10,2)) AS fatal_serious_rate_pct,
    SUM(is_fatal) AS fatal_count,
    cast(AVG(number_of_casualties*1.0) as decimal(10,2)) AS avg_casualties
FROM collisions2
WHERE urban_or_rural_area IS NOT NULL
GROUP BY urban_or_rural_area
ORDER BY total_collisions DESC;



-- ===== 3.4: Geographic Hotspots (by Latitude/Longitude Rounded) =====
SELECT 
    lat_round,lon_round,
    COUNT(*) AS total_collisions,
    SUM(is_fatal_or_serious) AS fatal_serious_count,
    CAST(AVG(is_fatal_or_serious *100.0) as DECIMAL(10,2)) AS fatal_serious_rate_pct
FROM collisions2
WHERE latitude IS NOT NULL AND longitude IS NOT NULL
GROUP BY 
lat_round,lon_round
HAVING COUNT(*) >= 10  -- Only show areas with at least 10 collisions
ORDER BY total_collisions DESC;


