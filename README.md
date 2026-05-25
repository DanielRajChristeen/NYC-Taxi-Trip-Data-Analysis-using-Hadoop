# NYC Taxi Trip Data Analysis using Hadoop

## Overview

This project builds an end-to-end Hadoop data pipeline using the NYC Taxi Trip dataset.

Pipeline includes:

- Data ingestion into HDFS
- ETL using Apache Pig
- Data warehousing using Apache Hive
- Partitioning and Bucketing optimization
- Analytical reporting
- Exporting processed outputs

---

## Dataset

This project uses the **NYC Taxi Trip Duration** dataset from Kaggle.

Dataset link:  
https://www.kaggle.com/c/nyc-taxi-trip-duration/data

### File used

train.csv

### Note

Dataset file is not included in this repository due to size constraints.

Download `train.csv` manually from Kaggle and place it in:

~/nyc_taxi/train.csv

---

## Tech Stack

- Hadoop HDFS
- Apache Pig
- Apache Hive
- Linux Shell
- ORC File Format

---

## Project Flow

CSV Dataset  
↓  
HDFS Raw Layer  
↓  
Pig ETL Cleaning & Transformation  
↓  
Hive External Table  
↓  
Hive ORC Partitioned Table  
↓  
Analytical Queries  
↓  
CSV Output Files

---

## Analytics Performed

### Peak Hours Analysis
Find busiest taxi demand hours.

### Monthly Trends
Analyze month-wise trip volume.

### Trip Duration Statistics
Calculate:
- Average trip duration
- Maximum trip duration
- Minimum trip duration

### Vendor Performance
Compare:
- Total trips by vendor
- Average trip duration by vendor

---

## Output Files

- peak_hours.csv
- monthly_trends.csv
- duration_stats.csv
- vendor_performance.csv

---

## Key Learnings

- HDFS data ingestion
- ETL pipeline development with Pig
- Hive data modeling
- Partitioning and Bucketing optimization
- Large-scale data analytics
- Exporting analytics outputs from Hadoop ecosystem

---

## Author

C Daniel Raj
