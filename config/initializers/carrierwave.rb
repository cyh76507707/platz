if Rails.env == 'production'
  CarrierWave.configure do |config|
    config.storage = :fog

    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      :region                => 'us-east-1'
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME']
  end
  AWS.config(
    region: 'us-east-1',
    s3_signature_version: :v4
  )
end