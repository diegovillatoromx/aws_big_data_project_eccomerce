#!/bin/bash

# Load variables from JSON configuration file
config_file="./config/kinesis_stream_2_config.json"

# Extract values from JSON file using jq
aws_region=$(jq -r '.aws_settings.aws_region' $config_file)
stream_name=$(jq -r '.kinesis_settings.stream_name' $config_file)
shard_count=$(jq -r '.kinesis_settings.shard_count' $config_file)
retention_period_hours=$(jq -r '.kinesis_settings.retention_period_hours' $config_file)
capacity_mode=$(jq -r '.kinesis_settings.capacityMode' $config_file)

# AWS CLI command to create Kinesis Data Stream
aws kinesis create-stream \
  --stream-name $stream_name \
  --shard-count $shard_count \
  --retention-period-hours $retention_period_hours \
  --capacity-mode $capacity_mode \
  --region $aws_region

echo "Kinesis Data Stream '$stream_name' created successfully in the region '$aws_region' with capacity mode '$capacity_mode'."