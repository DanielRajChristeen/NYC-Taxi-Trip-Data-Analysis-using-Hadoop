USE nyc_taxi_db;

INSERT OVERWRITE DIRECTORY '/data/nyc_taxi/output/peak_hours'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT hour, COUNT(*) AS trip_count
FROM taxi_trips
GROUP BY hour;

INSERT OVERWRITE DIRECTORY '/data/nyc_taxi/output/monthly_trends'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT year, month, COUNT(*) AS total_trips
FROM taxi_trips
GROUP BY year, month;

INSERT OVERWRITE DIRECTORY '/data/nyc_taxi/output/duration_stats'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT
AVG(trip_duration),
MAX(trip_duration),
MIN(trip_duration)
FROM taxi_trips;

INSERT OVERWRITE DIRECTORY '/data/nyc_taxi/output/vendor_performance'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT
vendor_id,
COUNT(*) AS total_trips,
AVG(trip_duration) AS avg_duration
FROM taxi_trips
GROUP BY vendor_id;
