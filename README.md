# Data Engineering Project: Empowering eCommerce with an Analytical Platform Built on AWS Services
Ecommerce analytics is the process of collecting data from all of the sources that affect a certain shop. Analysts can then utilize this information to deduce changes in customer behavior and online shopping patterns. Ecommerce analytics spans the whole customer journey.

```arduino
├── src/
│   ├── your_code.py
├── scripts/
│   ├── deploy.sh
│   ├── run.py
├── README.md
```

## Table of Contents 

- [Description](#description)
- [Architecture](#architecture)
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

![diagram](https://github.com/diegovillatoromx/flink-kinesis-streaming-pipeline/blob/main/images/flink_kinesis.png)
