# Data Engineering Project: Empowering eCommerce with an Analytical Platform Built on AWS Services

Welcome to the Ecommerce Analytics project! As a seasoned Senior Data Engineer, I've developed this repository to showcase comprehensive insights derived from the intricate web of data influencing online shopping experiences. The project revolves around leveraging an eCommerce dataset to emulate `user interactions—purchases`, `product views`, `cart activities`, and the entire `customer journey`.  

## Table of Contents  

- [Description](#description)
- [Architecture](#architecture)
- [Dataset](#Dataset)
- [Modular Code Overview](#modular-code-overview)
- [Methodology](#Methodology)
- [Contribution](#contribution)
- [Contact](#contact)
 
## Description

A data pipeline serves as a sophisticated mechanism for seamlessly transporting data from one system to another. This process is dynamic, accommodating scenarios where data updates may or may not occur, and it operates in real-time or streaming mode rather than relying solely on batch processing.

The comprehensive scope of a data pipeline encompasses a series of stages, starting from the acquisition or harvesting of data through diverse methods. The journey continues with storing the raw data, followed by cleaning, validating, and transforming it into a format conducive to queries. The pipeline's responsibilities extend to showcasing Key Performance Indicators (KPIs) and overseeing the entire process.
 
```sql
| Component             | Description                                                                                                         |
| --------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Analytical Pipelines** | Introduces two robust pipelines—Batch and Real-time. The Batch processing pipeline involves data ingestion, Lake House architecture, processing, and visualization using Amazon Kinesis, Glue, S3, and QuickSight. |
| **Insights Generated**   | - Unique daily visitors
                            - User behavior analysis during specific time frames, focusing on cart additions without purchases.
                            - Top categories trending hourly or by weekday for strategic promotions.
                            - Identifying brands needing intensified marketing efforts. |
| **Real-time Channel**  | Swiftly detects and mitigates potential threats, specifically DDoS and Bot attacks, using a dynamic combination of AWS Lambda, DynamoDB, CloudWatch, and AWS SNS. |
```

This repository showcases the fusion of data engineering and eCommerce analytics, capturing the nuances of online customer engagement and security. Explore the codebase to unveil the depth of insights derived from a well-crafted data strategy.


## AWS Data Engineering Pipeline Architecture

This AWS Data Engineering project demonstrates a resilient and scalable pipeline architecture leveraging essential AWS services. Starting with efficient storage in Amazon S3 and progressing to serverless integration using AWS Glue, interactive querying via Athena, and real-time analytics powered by Apache Flink and Amazon Kinesis, each component plays a crucial role.

The business intelligence layer is bolstered by QuickSight, while AWS Glue DataBrew streamlines visual data preparation. The seamless integration with Amazon DynamoDB ensures rapid and predictable performance, accompanied by uninterrupted scalability. This summary underscores the synergy of AWS services throughout the pipeline, establishing a robust foundation for advanced analytics and well-informed decision-making. 
![diagram](https://github.com/diegovillatoromx/aws_big_data_project_eccomerce/blob/main/images/ecomm_platform.png)

The  key AWS services utilized are:
```css
| Component             | Description                                                                                                         |
| --------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Amazon S3             | Utilized as scalable object storage, forming the foundational layer for storing and retrieving data seamlessly in the data engineering pipeline.                              |
| AWS Glue              | A serverless data integration service central to discovering, preparing, and integrating data for analytics and machine learning. Efficiently runs Spark/Python code. |
| AWS Athena            | A serverless query service empowering interactive and efficient querying of data in Amazon S3 without the need for pre-loading. Supports multiple data formats, enhancing flexibility.    |
| Apache Flink          | At the core of real-time data analytics, handling massive data streams and providing valuable insights in real-time. Excels in distributed computations over data streams.                 |
| Amazon Kinesis        | In real-time data collection, processing, and transfer, Data Streams and Data Firehose play pivotal roles. Firehose simplifies delivery and supports data transformation in the pipeline.     |
| QuickSight            | A scalable, serverless business intelligence (BI) layer connecting to various sources in the architecture. Pay-per-session pricing ensures cost-effectiveness for large-scale deployments.    |
| AWS Glue DataBrew     | A visual tool expediting cleaning and normalization in the data preparation phase. Enhances the efficiency of data prep for downstream analytics and machine learning.                   |
| Amazon DynamoDB       | A fully managed NoSQL database service seamlessly integrated into the pipeline architecture. Quick, predictable performance with seamless scaling and enhanced querying flexibility (PartiQL). |

```

## Dataset 

This file contain behavior [data](https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store/data) for 7 months (from October 2019 to April 2020) from a large multi-category online store. Each row in the file represents an event. All events are related to products and users. Each event is like many-to-many relation between products and users.

Dive into the intricacies of user behavior with this dataset, meticulously curated from a expansive multi-category online store. The dataset comprises crucial fields including `event_time`, `event_type`, `product_id`, `price`, and `user_id`. Each row in the file corresponds to one of the following event types:

- **View**
- **Cart**
- **Removed from Cart**
- **Purchase**

Uncover valuable insights as you navigate through the wealth of user behavioral information, dissecting events that shape the online shopping experience.

## Methodology
### I. Creation of the Python Simulator (App)

1. **Creation of S3 Bucket for Ecommerce Dataset:**
   We will use AWS CLI to establish an S3 bucket that will act as the primary repository for the ecommerce dataset. This bucket will be crucial as the data source for our project. First, we have to deploy `deploy_s3_dataset_bucket.sh` to do this, you have to navigate:
   ```python
   infrastructure/deploy_s3_dataset_bucket.sh
   ```
   We establish the S3 bucket in AWS using AWS CLI
   ```terminal
   chmod +x deploy_s3_dataset_bucket.sh
   ./deploy_s3_dataset_bucket.sh
   ```
   The dataset [data](https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store/data) is available for download either from Kaggle or directly through the terminal. To obtain it, you can use the following command in your terminal:
   ```bash
   kaggle datasets download -d mkechinov/ecommerce-behavior-data-from-multi-category-store
   ```
   In order to make this dataset accessible within our AWS environment, it's necessary to copy the downloaded file from your local machine to an S3 bucket. We have a specific S3 bucket named `'ecommerce-raw-731613642368-dev-s3'` that has been created for this purpose. Additionally, a folder within the bucket named `'ecomm_user_raw_dataset'` has been set up. You can use the AWS Command Line Interface (CLI) to upload the file to the S3 bucket with the following command:
   ```bash
   aws s3 cp <local-file-path> s3://ecommerce-raw-731613642368-dev-s3/ecomm_user_raw_dataset/
   ```
   Make sure to replace `<local-file-path>` with the actual path to the downloaded dataset on your local machine. Once the file is copied to the S3 bucket, it will be accessible for further data processing and analysis within our AWS environment.
   
3. **Creation of Data Stream for Real-Time Data Ingestion:**
   Using AWS CLI, we will configure a data stream responsible for receiving real-time data `ecomm_user_activity_stream_1`. This data stream will be the main avenue for continuous data ingestion. Second, we have to deploy `deploy_kinesis_stream_2.sh` to do this, you have to navigate:
   ```python
   infrastructure/deploy_kinesis_stream_1.sh
   ```
   We establish the S3 bucket in AWS using AWS CLI
   ```terminal
   chmod +x deploy_kinesis_stream_1.sh
   ./deploy_kinesis_stream_1.sh
   ```

4. **Development of the Python Simulator:**
   We will implement a Python script that simulates data generation for our project. This script will perform the following actions:
   - Extract data from the dataset stored in the newly created S3 bucket.
   - Send simulated data to the data stream, simulating continuous real-time data ingestion.

   First of all, you have to create an IAM Role:
   #### Create an IAM Role:
   - Go to the [IAM console](https://console.aws.amazon.com/iam/).
   - In the navigation pane, choose `"Roles"` and then click on the `"Create role"` button.
   - For `"Select type of trusted entity"` choose `"AWS service"`
   - Under `"Choose a use case"` find and select `"EC2"` even if you're not using EC2 directly. This is a common option for roles used locally.
   - Click `"Next: Permissions"`
   - In the `"Permissions"` step, attach the necessary policies to the role. For example, if you need access to S3 and Kinesis, you can attach policies like `"AmazonS3FullAccess"` and `"AmazonKinesisFullAccess"`. You can search for these policies and select them.
   - Click `"Next: Tags"` if you want to add tags, otherwise, click `"Next: Review"`
   - Provide a name for your role in the `"Role name"` field.
   - Optionally, you can provide a description for the role.
   - Click `"Create role"`
   
   Now you have successfully created an IAM role. This role can be assumed by your code to obtain temporary credentials. Remember to configure your AWS CLI or SDK to use this role when running your Python script. To configure AWS CLI with profiles and using the role created following the next steps:

   #### Configure AWS CLI with Profiles:
   1. Open the `~/.aws/config` file in a text editor:
      ```bash
      nano ~/.aws/config
      ```
   2. Add the following configuration:
      ```plaintext
      [profile my_profile]
      role_arn = arn:aws:iam::YOUR_ACCOUNT:role/my_role
      source_profile = default
      ```

      - `my_profile`: A descriptive name for the new profile you are creating.
      - `role_arn`: The ARN of the IAM role you created in the IAM console.
      - `source_profile`: The existing profile that contains your AWS credentials. In this case, assuming it's the `default` profile.

   3. Save the file and close it.
   
   Now, when you want to use the `my_profile` profile for AWS CLI commands or when writing Python scripts using `boto3`, you can specify the profile:
   For AWS CLI:
   ```bash
   aws s3 ls --profile my_profile
   ```
   For boto3 in Python:
   ```python
   import boto3
   session = boto3.Session(profile_name='my_profile')
   s3_client = session.client('s3')
   # Now you can use s3_client to interact with S3 using the my_profile profile.
   ```


6. **Execution of the Simulator:**
   We will execute the Python simulation script to verify the correct extraction of data from the S3 bucket and its successful transmission to the data stream.

7. **Validation in AWS Console:**
   We will check the AWS console to ensure that the S3 bucket contains ecommerce data and that the data stream is receiving data from the Python simulator.

These initial steps are part of the infrastructure-building process and set the foundation for the development of the real-time data pipeline. The upcoming phases will address the creation of other key components using AWS CLI, followed by the automation of these processes using Boto3 in Python.

### II. Real-time Analytics Pipeline

#### Table Definition:

- Use SQL statements to define the structures of the two tables representing the two data streams. In the provided example, these are `ecomm_user_activity_stream_1` and `ecomm_user_activity_stream_2`.
- Specify the fields for each table, their data types, and any additional configurations such as primary keys, watermarks, and partitions.

```sql
%flink.ssql

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
  'stream' = 'ecommerce-raw-us-east-1-731613642368-dev-stream-1',
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
  'stream' = 'ecommerce-raw-us-east-1-731613642368-dev-stream-2',
  'aws.region' = 'us-east-1',
  'format' = 'json',
  'json.timestamp-format.standard' = 'ISO-8601'
);
```

#### Connection to Data Streams:

- Configure the tables to connect to the corresponding data streams. In the example, the 'kinesis' connector is used, specifying AWS region and other relevant parameters.

#### Data Processing:

- Use SQL statements to perform processing operations on the data from the two streams. In the example, an aggregation operation is performed on `ecomm_user_activity_stream_1`, and the results are inserted into `ecomm_user_activity_stream_2`.
- Apply any additional processing logic based on your requirements, such as filtering, transformations, and data enrichment.

```sql
-- Inserting aggregation into Stream 2
INSERT INTO ecomm_user_activity_stream_2
SELECT user_id, COUNT(1) AS num_actions_per_watermark
FROM ecomm_user_activity_stream_1
GROUP BY TUMBLE(txn_timestamp, INTERVAL '10' SECOND), user_id
HAVING COUNT(1) > 1;
```

### III. Analytics on Dahsboard 
We will utilize an eCommerce dataset to simulate user interactions, including purchase logs, product views, cart history, and the user's online journey. Our goal is to establish two analytical pipelines: one for batch processing and another for real-time analytics.

The real-time pipeline is designed to detect and mitigate Distributed Denial of Service (DDoS) and Bot attacks. The implementation leverages several AWS services:

- **AWS Lambda:** Utilized for serverless computing and event-driven architecture.
- **DynamoDB:** Employed as a NoSQL database for efficient data storage.
- **CloudWatch:** Used for monitoring and logging activities.
- **AWS SNS (Simple Notification Service):** Enables event-driven communication.

##### Implementation Details

1. **Lambda Functions:**
   - Developed specific Lambda functions for DynamoDB and SNS to facilitate seamless communication and data handling.

2. **DynamoDB Data Modeling:** 
   - Ensured proficient understanding and application of DynamoDB data modeling for optimal performance and scalability.

3. **Lambda and Kinesis Integration:**
   - Integrated Lambda functions with Kinesis for real-time data streaming and processing.

4. **ETL Processes:**
   - Executed Extract, Transform, Load (ETL) processes to convert data into Parquet format.
   - Leveraged Glue DataBrew for data preparation and Spark for large-scale data processing.

5. **QuickSight Dashboards:**
   - Created QuickSight Dashboards to provide insightful visualizations and analytics based on the processed data.

### IV. Importance of Pushing Raw Data to S3 as a Single Source of Truth (SSOT)


Following the successful implementation of the Analytical and Real-time Layers, a critical imperative is the systematic transfer of raw data to Amazon S3 (Simple Storage Service). This strategic initiative serves to solidify a Single Source of Truth (SSOT) for the entirety of the dataset.

#### Implementation:

To operationalize this imperative, consider the following strategic steps:

1. **S3 Data Bucket:**
   - Establish a dedicated S3 bucket to securely store the raw data.

2. **Data Pipeline Integration:**
   - Enhance the existing data pipeline to seamlessly incorporate a mechanism for pushing raw data to the designated S3 bucket.

3. **Versioning and Metadata:**
   - Implement robust versioning and metadata practices within the S3 bucket to amplify traceability and organization.

4. **Automated Processes:**
   - Consider the implementation of automated processes to streamline the raw data pushing mechanism, ensuring consistency and timely updates to the SSOT.

## Modular Code Overview
```arduino
 ├── src/
 │   ├── data_ingestion/
 │   │   ├── python_simulator.py
 │   ├── real-time_analytics_pipeline/
 │   │   ├── ecomm_user_activity.sql
 │   ├── mitigating_DDoS_and_Bot_attacks/
 │   │   ├── lambda_mitigation.py
 ├── infrastructure/
 │   ├── deploy_s3_dataset_bucket.sh
 │   ├── deploy_kinesis_stream_1.sh
 │   ├── deploy_kinesis_stream_2.sh
 │   ├── deploy_kinesis_analytics.sh
 │   ├── deploy_python_simulator.sh
 │   ├── deploy_lambda_mitigation.sh
 │   ├── deploy_dynamodb_table.sh
 │   ├── deploy_cloudwatch_dashboard.sh
 │   ├── deploy_sns_alerts.sh
 │   ├── deploy_s3_raw_ssto_parquet_bucket.sh
 │   ├── deploy_kinesis_firehose.sh
 ├── config/
 │   │   ├── s3_dataset_bucket_config.json 
 │   │   ├── kinesis_stream_1_config.json
 │   │   ├── kinesis_stream_2_config.json
 │   │   ├── kinesis_analytics_config.json
 │   │   ├── python_simulator_config.json
 │   │   ├── lambda_mitigation_config.json
 │   │   ├── dynamodb_table_config.json
 │   │   ├── cloudwatch_dashboard_config.json
 │   │   ├── sns_alerts_config.json
 │   │   ├── s3_raw_ssto_parquet_bucket_config.json
 │   │   ├── kinesis_firehose_config.json
 ├── images/
 │   ├── ecomm_platform.png
 ├── README.md
```

## Contribution
Feel free to contribute, share your thoughts, or utilize this project as a foundation for your data engineering endeavors. Happy coding!

