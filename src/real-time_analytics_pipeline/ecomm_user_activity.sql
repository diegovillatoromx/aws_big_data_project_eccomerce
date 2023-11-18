-- Table 1: ecomm_user_activity_stream_1
DROP TABLE IF EXISTS ecomm_user_activity_stream_1;

CREATE TABLE ecomm_user_activity_stream_1 (
  `event_time` VARCHAR(30),
  `event_type` VARCHAR(30),
  `product_id` BIGINT,
  `category_id` BIGINT,
  `category_code` VARCHAR(30),
  `brand` VARCHAR(30),
  `price` DOUBLE,
  `user_id` BIGINT,
  `user_session` VARCHAR(30),
  `txn_timestamp` TIMESTAMP(3),
  WATERMARK FOR txn_timestamp AS txn_timestamp - INTERVAL '10' SECOND
) 
PARTITIONED BY (category_id)
WITH (
  'connector' = 'kinesis',
  'stream' = 'ecommerce-raw-user-activity-stream-1',
  'aws.region' = 'us-east-1',
  'scan.stream.initpos' = 'LATEST',
  'format' = 'json',
  'json.timestamp-format.standard' = 'ISO-8601'
);

-- Table 2: ecomm_user_activity_stream_2
DROP TABLE IF EXISTS ecomm_user_activity_stream_2;

CREATE TABLE ecomm_user_activity_stream_2 (
  `user_id` BIGINT,
  `num_actions_per_watermark` BIGINT
) WITH (
  'connector' = 'kinesis',
  'stream' = 'ecommerce-raw-user-activity-stream-2',
  'aws.region' = 'us-east-1',
  'format' = 'json',
  'json.timestamp-format.standard' = 'ISO-8601'
);

-- Inserting aggregation into Stream 2
INSERT INTO ecomm_user_activity_stream_2
SELECT user_id, COUNT(1) AS num_actions_per_watermark
FROM ecomm_user_activity_stream_1
GROUP BY TUMBLE(txn_timestamp, INTERVAL '10' SECOND), user_id
HAVING COUNT(1) > 1;
