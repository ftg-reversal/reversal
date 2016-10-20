AssetSync.configure do |config|
  config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
  config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  config.fog_directory = 'reversal-cdn'
  config.fog_provider = 'AWS'
  config.fog_region = 'ap-northeast-1'
  config.gzip_compression = true
end
