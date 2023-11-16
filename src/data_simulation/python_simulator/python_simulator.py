import boto3
import csv
import json
from time import sleep
from datetime import datetime
import yaml

# Cargar configuraciones desde el archivo YAML
with open('config/python_simulator_config.yaml', 'r') as config_file:
    config = yaml.safe_load(config_file)

aws_settings = config['aws_settings']
kinesis_settings = config['kinesis_settings']
s3_settings = config['s3_settings']

aws_region = aws_settings['aws_region']
aws_account_id = aws_settings['aws_account_id']
env = aws_settings['env']
company = aws_settings['company']
stream_suffix = aws_settings['stream_suffix']

kinesis_stream_name = kinesis_settings['kinesis_stream_name']

s3_bucket_name = s3_settings['s3_bucket_name']

# Configuración de AWS
s3_client = boto3.client('s3', region_name=aws_region)
s3_resource = boto3.resource('s3', region_name=aws_region)
kinesis_client = boto3.client('kinesis', region_name=aws_region)

def read_csv_from_s3(bucket, key):
    csv_file = s3_resource.Object(bucket, key)
    s3_response = csv_file.get()
    lines = s3_response['Body'].read().decode('utf-8').split('\n')
    return lines

def convert_to_json_and_stream(data, partition_key):
    for row in csv.DictReader(data):
        try:
            line_json = json.dumps(row)
            json_load = json.loads(line_json)

            # Adding fake txn ts:
            json_load['txn_timestamp'] = datetime.now().isoformat()

            # Write to Kinesis Streams:
            response = kinesis_client.put_record(
                StreamName=kinesis_stream_name,
                Data=json.dumps(json_load, indent=4),
                PartitionKey=str(json_load[partition_key])
            )

            print('HttpStatusCode:', response['ResponseMetadata']['HTTPStatusCode'], ', ',
                  json_load['category_code'])

            # Adding a temporary pause, for demo-purposes:
            sleep(0.250)

        except Exception as e:
            print('Error: {}'.format(e))

def stream_data_simulator(input_s3_bucket, input_s3_key):
    lines = read_csv_from_s3(input_s3_bucket, input_s3_key)
    convert_to_json_and_stream(lines, 'category_id')

# Run stream:
for i in range(0, 5):
    stream_data_simulator(s3_bucket_name, 'ecomm_user_activity_sample/2019-Nov-sample.csv')

