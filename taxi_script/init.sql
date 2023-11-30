--создание raw таблицы
CREATE TABLE taxi
(
VendorID               UInt8,
tpep_pickup_datetime   datetime,
tpep_dropoff_datetime  datetime,
passenger_count        UInt8,
trip_distance          float,
RatecodeID             UInt8,
store_and_fwd_flag     String,
PULocationID           UInt16,
DOLocationID           UInt16,
payment_type           float,
fare_amount            float,
extra                  float,
mta_tax                float,
tip_amount             float,
tolls_amount           float,
improvement_surcharge  float,
total_amount           float,
congestion_surcharge   float
)
ENGINE = MergeTree()
ORDER BY (tpep_pickup_datetime);

--загрузка данных в raw таблицу
clickhouse-client --input_format_csv_skip_first_lines=1 \
 --date_time_input_format=best_effort -q "insert into taxi format CSV" < /csv/yellow_tripdata_2020-01.csv



--удаление лишних столбцов
ALTER TABLE taxi
  DROP COLUMN VendorID,
  DROP COLUMN tpep_dropoff_datetime,
  DROP COLUMN RatecodeID,
  DROP COLUMN store_and_fwd_flag,
  DROP COLUMN PULocationID,
  DROP COLUMN DOLocationID,
  DROP COLUMN payment_type,
  DROP COLUMN extra,
  DROP COLUMN mta_tax,
  DROP COLUMN tolls_amount,
  DROP COLUMN improvement_surcharge,
  DROP COLUMN congestion_surcharge;

--сохранение витрины в parquet 
сlickhouse-client -q "SELECT * FROM taxi_analyse_short FORMAT Parquet" > /MART/taxi_analyse_short.parquet\
&& clickhouse-client -q "SELECT * FROM taxi_analyse_long FORMAT Parquet" > /MART/taxi_analyse_long.parquet


--сохранение таблицы для дальнейшей аналитики 
clickhouse-client -q "SELECT * FROM taxi FORMAT CSVWithNames" > /csv/taxi.csv


