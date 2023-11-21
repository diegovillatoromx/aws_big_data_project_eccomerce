#!/bin/bash

# Load variables from JSON configuration file
config_file="./config/config.json"

# Extract values from JSON file using jq
aws_account_id=$(jq -r '.aws_settings.aws_account_id' "$config_file")
aws_region=$(jq -r '.aws_settings.aws_region' "$config_file")

# Application settings
app_name=$(jq -r '.analytics_settings.app_name' "$config_file")
input_stream=$(jq -r '.analytics_settings.input_stream' "$config_file")
output_stream=$(jq -r '.analytics_settings.output_stream' "$config_file")

# IAM Role for Kinesis Analytics execution
service_role_name="kinesis-analytics-ecommerce_user_activity_analytics-execution-role"
service_execution_role=""

# Path to the SQL code file
sql_code_file="./src/real-time_analytics_pipeline/ecomm_user_activity.sql"

# Read SQL code from the file
sql_code=$(cat "$sql_code_file")

# Check if the IAM role exists, create it if not
if ! aws iam get-role --role-name "$service_role_name" &> /dev/null; then
  service_execution_role=$(aws iam create-role --role-name "$service_role_name" \
    --assume-role-policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"kinesisanalytics.amazonaws.com"},"Action":"sts:AssumeRole"}]}' \
    --query "Role.Arn" --output text)

  echo "IAM role '$service_role_name' created successfully."
else
  service_execution_role=$(aws iam get-role --role-name "$service_role_name" --query "Role.Arn" --output text)
fi

# Create Kinesis Analytics application
aws kinesisanalyticsv2 create-application --application-name "$app_name" --runtime-environment "SQL-1_0" --service-execution-role "$service_execution_role" --region "$aws_region"

echo "Kinesis Analytics application '$app_name' created successfully."

# Add input stream to the application
aws kinesisanalyticsv2 add-application-input --application-name "$app_name" --input-configurations '[{"Id": "1","InputStartingPositionConfiguration": {"InputStartingPosition": "LAST_STOPPED_POINT"},"InputParallelism": {"Count": 1},"InputSchema": {"RecordColumns": [{"Name": "event_time","SqlType": "VARCHAR(30)"},{"Name": "event_type","SqlType": "VARCHAR(30)"},{"Name": "product_id","SqlType": "BIGINT"},{"Name": "category_id","SqlType": "BIGINT"},{"Name": "category_code","SqlType": "VARCHAR(30)"},{"Name": "brand","SqlType": "VARCHAR(30)"},{"Name": "price","SqlType": "DOUBLE"},{"Name": "user_id","SqlType": "BIGINT"},{"Name": "user_session","SqlType": "VARCHAR(30)"},{"Name": "txn_timestamp","SqlType": "TIMESTAMP(3)"}],"RecordFormat": {"RecordFormatType": "JSON","MappingParameters": {"JSONMappingParameters": {"RecordRowPath": "$"}}},"KinesisStreamsInput": {"ResourceARN": "arn:aws:kinesis:'$aws_region':'$aws_account_id':stream/'$input_stream'"}}}]' --region "$aws_region"

echo "Input stream for '$app_name' added successfully."

# Add output stream to the application
aws kinesisanalyticsv2 add-application-output --application-name "$app_name" --output-configurations '[{"Id": "1","Output": {"Name": "DESTINATION_SQL_STREAM_001","KinesisStreamsOutput": {"ResourceARN": "arn:aws:kinesis:'$aws_region':'$aws_account_id':stream/'$output_stream'"},"DestinationSchema": {"RecordFormatType": "JSON"}}}]' --region "$aws_region"

echo "Output stream for '$app_name' added successfully."

# Set SQL code for transformation
aws kinesisanalyticsv2 update-application --application-name "$app_name" --current-application-version-id 1 --application-code-configuration '{"CodeContentType": "PLAINTEXT","CodeContent": "'"$sql_code"'"}' --region "$aws_region"

echo "SQL code updated successfully for '$app_name'."
