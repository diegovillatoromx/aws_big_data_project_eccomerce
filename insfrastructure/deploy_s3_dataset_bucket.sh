#!/bin/bash

# Load variables from JSON configuration file
config_file="./config/s3_dataset_bucket_config.json"

# Extract values from JSON file using jq
s3_bucket_name=$(jq -r '.s3_settings.s3_bucket_name' $config_file)
acl=$(jq -r '.s3_settings.acl' $config_file)
block_public_access=$(jq -r '.s3_settings.block_public_access' $config_file)
versioning_enabled=$(jq -r '.s3_settings.versioning_enabled' $config_file)
default_encryption=$(jq -r '.s3_settings.default_encryption' $config_file)
location_constraint=$(jq -r '.s3_settings.create_bucket_configuration.LocationConstraint' $config_file)

# AWS CLI command to create S3 bucket with specified settings
aws s3api create-bucket \
  --bucket $s3_bucket_name \
  --acl $acl \
  --block-public-access "BlockPublicAcls=$block_public_access,IgnorePublicAcls=$block_public_access,BlockPublicPolicy=$block_public_access,RestrictPublicBuckets=$block_public_access" \
  --versioning-configuration Status=$versioning_enabled \
  --create-bucket-configuration LocationConstraint=$location_constraint

# Disable default encryption
if [ "$default_encryption" == "false" ]; then
  aws s3api put-bucket-encryption \
    --bucket $s3_bucket_name \
    --no-server-side-encryption-configuration
fi

echo "S3 bucket '$s3_bucket_name' created successfully in the region '$location_constraint' with specified settings."
