AWS.config(:logger => Rails.logger)

AWS.config(
  access_key_id: ENV['AMAZON_ACCESS_KEY_ID'],
  secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY']
)
