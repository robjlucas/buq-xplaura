CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('S3_BUCKET_NAME') # for AWS-side bucket access permissions config, see section below
    config.aws_acl    = 'private'

    config.aws_credentials = {
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      region:            ENV.fetch('AWS_REGION'), # Required
      stub_responses:    Rails.env.test? # Optional, avoid hitting S3 actual during tests
    }
  end
end
