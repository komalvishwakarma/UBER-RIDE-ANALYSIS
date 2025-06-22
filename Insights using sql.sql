create database uber_data;
use uber_data;

CREATE TABLE uber_requests (
  trip_id int,
  request_id int,
  pickup_point VARCHAR(50),
  driver_id VARCHAR(20),
  status VARCHAR(50),
  request_hour INT,
  request_timestamp DATETIME,
  drop_timestamp DATETIME,
  trip_duration_mins FLOAT,
  is_completed VARCHAR(10),
  time_slot VARCHAR(20),
  day VARCHAR(10)
);

select * from uber_requests;

SELECT COUNT(*) AS total_requests FROM uber_requests;

SELECT status, COUNT(*) AS total FROM uber_requests GROUP BY status;

SELECT pickup_point, COUNT(*) AS total FROM uber_requests GROUP BY pickup_point;

SELECT pickup_point,
       COUNT(*) AS total_requests,
       SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancellations,
       ROUND(SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS cancellation_rate
FROM uber_requests
GROUP BY pickup_point;

SELECT request_hour, COUNT(*) AS total_requests
FROM uber_requests
GROUP BY request_hour
ORDER BY request_hour;

SELECT time_slot, status, COUNT(*) AS total
FROM uber_requests
GROUP BY time_slot, status
ORDER BY time_slot;

SELECT day, COUNT(*) AS total_requests
FROM uber_requests
GROUP BY day
ORDER BY FIELD(day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday');

SELECT ROUND(AVG(trip_duration_mins), 2) AS avg_trip_duration
FROM uber_requests
WHERE status = 'Trip Completed';

SELECT ROUND(AVG(trip_duration_mins), 2) AS avg_trip_duration, time_slot
FROM uber_requests
group by time_slot;

SELECT request_hour, COUNT(*) AS cancellations
FROM uber_requests
WHERE status = 'Cancelled'
GROUP BY request_hour
ORDER BY cancellations DESC
LIMIT 5;

SELECT status,
       COUNT(*) AS total,
       ROUND(COUNT(*) / (SELECT COUNT(*) FROM uber_requests) * 100, 2) AS percentage
FROM uber_requests
GROUP BY status;



