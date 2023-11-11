# Data Engineering Project: Empowering eCommerce with an Analytical Platform Built on AWS Services

Welcome to the Ecommerce Analytics project! As a seasoned Senior Data Engineer, I've developed this repository to showcase comprehensive insights derived from the intricate web of data influencing online shopping experiences. The project revolves around leveraging an eCommerce dataset to emulate user interactions—purchases, product views, cart activities, and the entire customer journey.

## Table of Contents 

- [Description](#description) 
- [Architecture](#architecture)
- [Modular Code Overview](#modular-code-overview)
- [Dataset](#Dataset)
- [Modular Code Overview](#modular-code-overview)
- [Methodology](#Methodology)
- [Contribution](#contribution)
- [Contact](#contact)

## Description

A data pipeline serves as a sophisticated mechanism for seamlessly transporting data from one system to another. This process is dynamic, accommodating scenarios where data updates may or may not occur, and it operates in real-time or streaming mode rather than relying solely on batch processing.

The comprehensive scope of a data pipeline encompasses a series of stages, starting from the acquisition or harvesting of data through diverse methods. The journey continues with storing the raw data, followed by cleaning, validating, and transforming it into a format conducive to queries. The pipeline's responsibilities extend to showcasing Key Performance Indicators (KPIs) and overseeing the entire process.

### Key Components:

#### Analytical Pipelines:

***[The project](https://github.com/diegovillatoromx/aws_big_data_project_eccomerce/)*** introduces two robust analytical pipelines—Batch and Real-time. The Batch processing pipeline encompasses data ingestion, Lake House architecture implementation, processing, and visualization using a powerful stack including Amazon Kinesis, Glue, S3, and QuickSight.

- **Insights Generated:**
  - Unique visitors per day
  - User behavior analysis during specific time frames, focusing on instances where products are added to carts but not purchased.
  - Top categories trending by hour or weekday for strategic promotional planning.
  - Identifying brands that require intensified marketing efforts.

#### Real-time Channel:
The Real-time channel is dedicated to swiftly detecting and mitigating potential threats, specifically Distributed Denial of Service (DDoS) and Bot attacks. This is achieved through a dynamic combination of AWS Lambda, DynamoDB, CloudWatch, and AWS SNS.

This repository serves as a testament to the fusion of data engineering expertise and eCommerce analytics, encapsulating the intricate dynamics of online customer engagement and security. Explore the codebase, delve into the pipelines, and uncover the depth of insights that can be gleaned from a well-crafted data strategy.


## AWS Data Engineering Pipeline Architecture

This AWS Data Engineering project showcases a robust and scalable pipeline architecture utilizing key AWS services. From efficient storage in Amazon S3 to serverless integration with AWS Glue, interactive querying with Athena, and real-time analytics with Apache Flink and Amazon Kinesis, each component plays a vital role.

The business intelligence layer is supported by QuickSight, while AWS Glue DataBrew streamlines visual data preparation. Seamless integration with Amazon DynamoDB ensures quick and predictable performance, coupled with uninterrupted scalability. This summary highlights the synergy of AWS services across the pipeline flow, establishing a solid foundation for advanced analytics and informed decision-making.
![diagram](https://github.com/diegovillatoromx/aws_big_data_project_eccomerce/blob/main/ecomm_platform.png)

The  key AWS services utilized are:
### Amazon S3

Utilized as scalable object storage, Amazon S3 forms the foundational layer for storing and retrieving data seamlessly throughout the data engineering pipeline.

### AWS Glue

As a serverless data integration service, AWS Glue takes center stage in discovering, preparing, and integrating data for analytics and machine learning. It efficiently runs Spark/Python code, ensuring a streamlined data processing flow.

### AWS Athena

Athena, a serverless query service, empowers interactive and efficient querying of data stored in Amazon S3 without the need for pre-loading. It supports multiple data formats, enhancing flexibility in analysis.

### Apache Flink

At the core of real-time data analytics, Apache Flink handles massive data streams, providing valuable insights in real-time. It excels in distributed computations over data streams within the architecture.

### Amazon Kinesis

Amazon Kinesis Data Streams and Kinesis Data Firehose play pivotal roles in real-time data collection, processing, and transfer. Kinesis Data Firehose simplifies the delivery process and supports data transformation within the pipeline.

### QuickSight

Amazon QuickSight serves as the scalable, serverless business intelligence (BI) layer, connecting to various sources in the architecture. Its pay-per-session pricing model ensures cost-effectiveness for large-scale deployments.

### AWS Glue DataBrew

In the data preparation phase, AWS Glue DataBrew, a visual tool, expedites cleaning and normalization activities. It plays a crucial role in enhancing the efficiency of data preparation for downstream analytics and machine learning.

### Amazon DynamoDB

Amazon DynamoDB, a fully managed NoSQL database service, seamlessly integrates into the pipeline architecture. Its quick and predictable performance, coupled with seamless scaling, ensures optimal handling of varied data loads. PartiQL support enhances the flexibility of querying data within DynamoDB.


## Dataset

This file contain behavior [data](https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store/data) for 7 months (from October 2019 to April 2020) from a large multi-category online store. Each row in the file represents an event. All events are related to products and users. Each event is like many-to-many relation between products and users.

Dive into the intricacies of user behavior with this dataset, meticulously curated from a expansive multi-category online store. The dataset comprises crucial fields including `event_time`, `event_type`, `product_id`, `price`, and `user_id`. Each row in the file corresponds to one of the following event types:

- **View**
- **Cart**
- **Removed from Cart**
- **Purchase**

Uncover valuable insights as you navigate through the wealth of user behavioral information, dissecting events that shape the online shopping experience.

## Methodology
### Creation of the Python Simulator (App)

1. **Creation of S3 Bucket for Ecommerce Dataset:**
   We will use AWS CLI to establish an S3 bucket that will act as the primary repository for the ecommerce dataset. This bucket will be crucial as the data source for our project.

2. **Creation of Data Stream for Real-Time Data Ingestion:**
   Using AWS CLI, we will configure a data stream responsible for receiving real-time data. This data stream will be the main avenue for continuous data ingestion.

3. **Development of the Python Simulator:**
   We will implement a Python script that simulates data generation for our project. This script will perform the following actions:
   - Extract data from the dataset stored in the newly created S3 bucket.
   - Send simulated data to the data stream, simulating continuous real-time data ingestion.

4. **Execution of the Simulator:**
   We will execute the Python simulation script to verify the correct extraction of data from the S3 bucket and its successful transmission to the data stream.

5. **Validation in AWS Console:**
   We will check the AWS console to ensure that the S3 bucket contains ecommerce data and that the data stream is receiving data from the Python simulator.

These initial steps are part of the infrastructure-building process and set the foundation for the development of the real-time data pipeline. The upcoming phases will address the creation of other key components using AWS CLI, followed by the automation of these processes using Boto3 in Python.

### Methodology for Processing Two Data Streams with Apache Flink SQL

#### Table Definition:

- Use SQL statements to define the structures of the two tables representing the two data streams. In the provided example, these are `ecomm_user_activity_stream_1` and `ecomm_user_activity_stream_2`.
- Specify the fields for each table, their data types, and any additional configurations such as primary keys, watermarks, and partitions.

#### Connection to Data Streams:

- Configure the tables to connect to the corresponding data streams. In the example, the 'kinesis' connector is used, specifying AWS region and other relevant parameters.

#### Data Processing:

- Use SQL statements to perform processing operations on the data from the two streams. In the example, an aggregation operation is performed on `ecomm_user_activity_stream_1`, and the results are inserted into `ecomm_user_activity_stream_2`.
- Apply any additional processing logic based on your requirements, such as filtering, transformations, and data enrichment.


## Modular Code Overview
```arduino
 ├── src/
 │   ├── stream_1_producer/
 │   │   ├── your_stream_1_producer.py
 ├── s3_firehose/
 │   ├── firehose_to_s3_delivery_stream/
 │   │   ├── your_firehose_to_s3_delivery_stream_config.json
 ├── kinesis_analytics/
 │   ├── stream_1_to_stream_2_application/
 │   │   ├── your_stream_1_to_stream_2_application.sql
 ├── glue_catalog/
 │   ├── glue_job/
 │   │   ├── your_glue_job_script.py
 ├── lambda/
 │   ├── stream_2_processing_lambda/
 │   │   ├── your_stream_2_processing_lambda.py
 ├── cloudwatch_dashboard/
 │   ├── your_dashboard_config.json
 ├── sns/
 │   ├── sns_alerts/
 │   │   ├── your_sns_alerts_config.json
 ├── dynamodb/
 │   ├── dynamodb_table/
 │   │   ├── your_dynamodb_table_config.json
 ├── scripts/
 │   ├── deploy_stream_1_producer.sh
 │   ├── deploy_firehose_to_s3.sh
 │   ├── deploy_stream_1_to_stream_2_application.sh
 │   ├── deploy_glue_job.sh
 │   ├── deploy_stream_2_processing_lambda.sh
 │   ├── deploy_dashboard.sh
 │   ├── deploy_sns_alerts.sh
 │   ├── deploy_dynamodb_table.sh
 ├── config/
 │   ├── stream_1_producer_config.yaml
 │   ├── firehose_to_s3_config.yaml
 │   ├── stream_1_to_stream_2_application_config.yaml
 │   ├── glue_job_config.yaml
 │   ├── stream_2_processing_lambda_config.yaml
 │   ├── dashboard_config.yaml
 │   ├── sns_alerts_config.yaml
 │   ├── dynamodb_table_config.yaml
 ├── README.md
```

## Usage
## Contribution
Feel free to contribute, share your thoughts, or utilize this project as a foundation for your data engineering endeavors. Happy coding!

