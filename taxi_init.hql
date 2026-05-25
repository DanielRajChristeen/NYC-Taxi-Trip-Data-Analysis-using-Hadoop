CREATE DATABASE IF NOT EXISTS nyc_taxi_db;
USE nyc_taxi_db;

DROP TABLE IF EXISTS staged_taxi_data;
DROP TABLE IF EXISTS taxi_trips;

CREATE EXTERNAL TABLE staged_taxi_data (
    id STRING,
    vendor_id STRING,
    pickup_ts STRING,
    dropoff_ts STRING,
    passenger_count INT,
    pickup_longitude DOUBLE,
    pickup_latitude DOUBLE,
    dropoff_longitude DOUBLE,
    dropoff_latitude DOUBLE,
    store_and_fwd_flag STRING,
    trip_duration INT,
    year INT,
    month INT,
    hour INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/nyc_taxi/staged/cleaned_taxi_data';

CREATE TABLE taxi_trips (
    id STRING,
    vendor_id STRING,
    pickup_ts TIMESTAMP,
    dropoff_ts TIMESTAMP,
    passenger_count INT,
    pickup_longitude DOUBLE,
    pickup_latitude DOUBLE,
    dropoff_longitude DOUBLE,
    dropoff_latitude DOUBLE,
    store_and_fwd_flag STRING,
    trip_duration INT,
    hour INT
)
PARTITIONED BY (year INT, month INT)
CLUSTERED BY (vendor_id) INTO 2 BUCKETS
STORED AS ORC;

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.enforce.bucketing=true;

INSERT INTO TABLE taxi_trips PARTITION (year, month)
SELECT
    id,
    vendor_id,
    CAST(pickup_ts AS TIMESTAMP),
    CAST(dropoff_ts AS TIMESTAMP),
    passenger_count,
    pickup_longitude,
    pickup_latitude,
    dropoff_longitude,
    dropoff_latitude,
    store_and_fwd_flag,
    trip_duration,
    hour,
    year,
    month
FROM staged_taxi_data;
