--таблица с аналитикой

CREATE VIEW taxi_analyse_short AS
SELECT 
    toDate(tpep_pickup_datetime) AS date,
    ((countIf(passenger_count = 0)) /  count()) *100 as percentage_zero,
    ((countIf(passenger_count = 1)) /  count()) *100 as percentage_1p,
    ((countIf(passenger_count = 2)) /  count()) *100 as percentage_2p,
    ((countIf(passenger_count = 3)) /  count()) *100 as percentage_3p,
    ((countIf(passenger_count >= 4)) /  count()) *100 as percentage_4p_plus,
    max(total_amount) as max_fare,
    min(total_amount) as min_fare
FROM 
    default.taxi
    WHERE total_amount >=0
GROUP BY 
    date
ORDER BY 
    date;


--еще вариант так как непонятно какую стоимость считать минимальной/максимальной в какой группе (группе дат или процентов).

CREATE VIEW taxi_analyse_long AS   
SELECT 
    date,
    percentage_zero,
    max_fare_zero,
    min_fare_zero,
    percentage_1p,
    max_fare_1p,
    min_fare_1p,
    percentage_2p,
    max_fare_2p,
    min_fare_2p,
    percentage_3p,
    max_fare_3p,
    min_fare_3p,
    percentage_4p_plus,
    max_fare_4p_plus,
    min_fare_4p_plus
FROM 
    (
        SELECT 
            toDate(tpep_pickup_datetime) AS date,
            ((countIf(passenger_count = 0)) /  count()) *100 as percentage_zero,
            maxIf(total_amount, passenger_count = 0) as max_fare_zero,
            minIf(total_amount, passenger_count = 0) as min_fare_zero,
            ((countIf(passenger_count = 1)) /  count()) *100 as percentage_1p,
            maxIf(total_amount, passenger_count = 1) as max_fare_1p,
            minIf(total_amount, passenger_count = 1) as min_fare_1p,
            ((countIf(passenger_count = 2)) /  count()) *100 as percentage_2p,
            maxIf(total_amount, passenger_count = 2) as max_fare_2p,
            minIf(total_amount, passenger_count = 2) as min_fare_2p,
            ((countIf(passenger_count = 3)) /  count()) *100 as percentage_3p,
            maxIf(total_amount, passenger_count = 3) as max_fare_3p,
            minIf(total_amount, passenger_count = 3) as min_fare_3p,
            ((countIf(passenger_count >= 4)) /  count()) *100 as percentage_4p_plus,
            maxIf(total_amount, passenger_count >= 4) as max_fare_4p_plus,
            minIf(total_amount, passenger_count >= 4) as min_fare_4p_plus
        FROM 
            default.taxi
        WHERE total_amount >=0
        GROUP BY 
            date
    )
ORDER BY 
    date;