import boto3
import csv
import json
from time import sleep
from datetime import datetime

# Load configurations from the JSON file
with open('config/python_simulator_config.json', 'r') as config_file:
    config = json.load(config_file)

# Get variables from the configuration file
aws_region = config['aws_settings']['aws_region']
s3_bucket_name = config['s3_settings']['s3_bucket_name']
kinesis_stream_name = config['kinesis_settings']['kinesis_stream_name']
csv_file_key = config['s3_settings']['csv_file_key']
streaming_partition_key = config['streaming_partition_key']

# AWS configuration without providing access keys (already configured via AWS CLI)
s3_client = boto3.client('s3', region_name=aws_region)
s3_resource = boto3.resource('s3', region_name=aws_region)
kinesis_client = boto3.client('kinesis', region_name=aws_region)

# Function to read the CSV file from S3
def read_csv_from_s3(bucket, key):
    csv_file = s3_resource.Object(bucket, key)
    s3_response = csv_file.get()
    lines = s3_response['Body'].read().decode('utf-8').split('\n')
    return lines

# Function to convert to JSON and send to Kinesis
def convert_to_json_and_stream(data, partition_key):
    for row in csv.DictReader(data):
        try:
            line_json = json.dumps(row)
            json_load = json.loads(line_json)

            # Add a fictitious timestamp:
            json_load['txn_timestamp'] = datetime.now().isoformat()

            # Send to Kinesis Streams:
            response = kinesis_client.put_record(
                StreamName=kinesis_stream_name,
                Data=json.dumps(json_load, indent=4),
                PartitionKey=str(json_load[partition_key])
            )

            print('HttpStatusCode:', response['ResponseMetadata']['HTTPStatusCode'], ', ',
                  json_load['category_code'])

            # Add a temporary pause for demonstration purposes:
            sleep(0.250)

        except Exception as e:
            print('Error: {}'.format(e))

# Main function to simulate data streaming
def stream_data_simulator(input_s3_bucket, input_s3_key):
    lines = read_csv_from_s3(input_s3_bucket, input_s3_key)
    convert_to_json_and_stream(lines, streaming_partition_key)

# Run the data streaming simulation:
for i in range(0, 2):
    stream_data_simulator(s3_bucket_name, csv_file_key)
