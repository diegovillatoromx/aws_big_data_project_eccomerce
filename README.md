# Data Engineering Project: Empowering eCommerce with an Analytical Platform Built on AWS Services

Welcome to the Ecommerce Analytics project! As a seasoned Senior Data Engineer, I've developed this repository to showcase comprehensive insights derived from the intricate web of data influencing online shopping experiences. The project revolves around leveraging an eCommerce dataset to emulate user interactions—purchases, product views, cart activities, and the entire customer journey.

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

A data pipeline serves as a sophisticated mechanism for seamlessly transporting data from one system to another. This process is dynamic, accommodating scenarios where data updates may or may not occur, and it operates in real-time or streaming mode rather than relying solely on batch processing.

The comprehensive scope of a data pipeline encompasses a series of stages, starting from the acquisition or harvesting of data through diverse methods. The journey continues with storing the raw data, followed by cleaning, validating, and transforming it into a format conducive to queries. The pipeline's responsibilities extend to showcasing Key Performance Indicators (KPIs) and overseeing the entire process.

***[The project](https://github.com/diegovillatoromx/aws_big_data_project_eccomerce/)*** introduces two robust analytical pipelines—Batch and Real-time. The Batch processing pipeline encompasses data ingestion, Lake House architecture implementation, processing, and visualization using a powerful stack including Amazon Kinesis, Glue, S3, and QuickSight.

- **Insights Generated:**
  - Unique visitors per day
  - User behavior analysis during specific time frames, focusing on instances where products are added to carts but not purchased.
  - Top categories trending by hour or weekday for strategic promotional planning.
  - Identifying brands that require intensified marketing efforts.

### Real-time Channel:
The Real-time channel is dedicated to swiftly detecting and mitigating potential threats, specifically Distributed Denial of Service (DDoS) and Bot attacks. This is achieved through a dynamic combination of AWS Lambda, DynamoDB, CloudWatch, and AWS SNS.

This repository serves as a testament to the fusion of data engineering expertise and eCommerce analytics, encapsulating the intricate dynamics of online customer engagement and security. Explore the codebase, delve into the pipelines, and uncover the depth of insights that can be gleaned from a well-crafted data strategy.

In summary, a data pipeline is a multifaceted solution that orchestrates the flow of data, from its inception to a state where it is refined, organized, and ready for insightful analysis.


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

## Dataset

Dive into the intricacies of user behavior with this dataset, meticulously curated from a expansive multi-category online store. The dataset comprises crucial fields including `event_time`, `event_type`, `product_id`, `price`, and `user_id`. Each row in the file corresponds to one of the following event types:

- **View**
- **Cart**
- **Removed from Cart**
- **Purchase**

Uncover valuable insights as you navigate through the wealth of user behavioral information, dissecting events that shape the online shopping experience.


## Contribution
Feel free to contribute, share your thoughts, or utilize this project as a foundation for your data engineering endeavors. Happy coding!

