raw_data = LOAD '/data/nyc_taxi/raw/train.csv'
USING PigStorage(',')
AS (
    id:chararray,
    vendor_id:chararray,
    pickup_datetime:chararray,
    dropoff_datetime:chararray,
    passenger_count:int,
    pickup_longitude:double,
    pickup_latitude:double,
    dropoff_longitude:double,
    dropoff_latitude:double,
    store_and_fwd_flag:chararray,
    trip_duration:int
);

filtered_data = FILTER raw_data BY id != 'id';

clean_data = FILTER filtered_data BY
    passenger_count > 0 AND
    pickup_longitude IS NOT NULL AND
    pickup_latitude IS NOT NULL AND
    dropoff_longitude IS NOT NULL AND
    dropoff_latitude IS NOT NULL AND
    trip_duration > 60 AND trip_duration < 10800;

formatted_data = FOREACH clean_data GENERATE
    id,
    vendor_id,
    REPLACE(SUBSTRING(pickup_datetime,0,19),'T',' ') AS pickup_ts,
    REPLACE(SUBSTRING(dropoff_datetime,0,19),'T',' ') AS dropoff_ts,
    passenger_count,
    pickup_longitude,
    pickup_latitude,
    dropoff_longitude,
    dropoff_latitude,
    store_and_fwd_flag,
    trip_duration;

enriched_data = FOREACH formatted_data GENERATE
    *,
    (int)SUBSTRING(pickup_ts,0,4) AS year,
    (int)SUBSTRING(pickup_ts,5,7) AS month,
    (int)SUBSTRING(pickup_ts,11,13) AS hour;

STORE enriched_data INTO '/data/nyc_taxi/staged/cleaned_taxi_data'
USING PigStorage(',');
