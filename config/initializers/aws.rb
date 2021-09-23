require 'aws-sdk-core'

Aws.config.update(
  region: 'us-west-2',
  credentials: Aws::Credentials.new('123', 'xyz'),
  endpoint: 'http://localhost:4566',
)

sqs = Aws::SQS::Client.new(
  region: 'us-east-1',
  credentials: Aws::Credentials.new('123', 'xyz')
)
sqs.create_queue({ queue_name: 'default' })
