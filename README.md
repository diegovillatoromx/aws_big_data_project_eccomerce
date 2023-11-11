# Data Engineering Project: Empowering eCommerce with an Analytical Platform Built on AWS Services

Welcome to the Ecommerce Analytics project! As a seasoned Senior Data Engineer, I've developed this repository to showcase comprehensive insights derived from the intricate web of data influencing online shopping experiences. The project revolves around leveraging an eCommerce dataset to emulate user interactions—purchases, product views, cart activities, and the entire customer journey.

## Key Components:

### Analytical Pipelines:
The project introduces two robust analytical pipelines—Batch and Real-time. The Batch processing pipeline encompasses data ingestion, Lake House architecture implementation, processing, and visualization using a powerful stack including Amazon Kinesis, Glue, S3, and QuickSight.

- **Insights Generated:**
  - Unique visitors per day
  - User behavior analysis during specific time frames, focusing on instances where products are added to carts but not purchased.
  - Top categories trending by hour or weekday for strategic promotional planning.
  - Identifying brands that require intensified marketing efforts.

### Real-time Channel:
The Real-time channel is dedicated to swiftly detecting and mitigating potential threats, specifically Distributed Denial of Service (DDoS) and Bot attacks. This is achieved through a dynamic combination of AWS Lambda, DynamoDB, CloudWatch, and AWS SNS.

This repository serves as a testament to the fusion of data engineering expertise and eCommerce analytics, encapsulating the intricate dynamics of online customer engagement and security. Explore the codebase, delve into the pipelines, and uncover the depth of insights that can be gleaned from a well-crafted data strategy.

## Table of Contents 

- [Description](#description) 
- [Architecture](#architecture)
- [Modular Code Overview](#modular-code-overview)
- [Dataset](#Dataset)
- [Methodology](#Methodology)
- [Modular Code Overview](#modular-code-overview)
- [Creating an AWS Cloud9 environment](#creating-an-AWS-Cloud9-environment)
- [Adding Policies to the Associated EC2 Instance](#Adding-Policies-to-the-Associated-EC2-Instance)
- [Setting up the enviroment](#setting-up-the-enviroment)
- [Cloning GitHub repository to AWS Cloud9](#Cloning-GitHub-repository-to-AWS-Cloud9)
- [Usage](#usage) 
- [Contribution](#contribution)
- [Contact](#contact)

## Description

The primary objective of this project is to develop an Extract, Transform, Load (ETL) solution using AWS CDK for the analysis of traffic accident analysis and prediction data. This process involves the construction of a serverless pipeline, in which Lambda functions are employed for data extraction from an app simulation and subsequent streaming into Kinesis streams. Additionally, a standalone Lambda function will be created to consume data from the Kinesis stream, apply essential transformations, and store them in s3.

To conduct real-time data analytics within the Kinesis streams, we will utilize Apache Flink and Apache Zeppelin. These tools will empower us to extract insights and derive valuable information from the data. AWS serverless technologies, including Amazon Lambda and Amazon Glue, will be leveraged for efficient processing and transformation of data from three distinct data sources.

Furthermore, Amazon Athena, a query service, will be used to analyze the transformed data stored in S3. This will facilitate efficient querying and data exploration, enabling us to extract meaningful insights and make informed decisions based on traffic accident analysis and prediction data.

By combining these AWS services and technologies, our aim is to create a robust and scalable solution for cryptocurrency data analysis, enabling comprehensive data processing, transformation, and analysis.

## Architecture

![diagram](https://github.com/diegovillatoromx/aws_big_data_project_eccomerce/blob/main/ecomm_platform.png))

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

## Contribution
Feel free to contribute, share your thoughts, or utilize this project as a foundation for your data engineering endeavors. Happy coding!

