Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  config.assets.compile = false
  config.assets.digest = true

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  config.logger = Logger.new('log/production.log', 10, 10 * 1024 * 1024)
  config.log_level = :info

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "reversal_#{Rails.env}"
  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  config.active_record.dump_schema_after_migration = false
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  config.active_record.raise_in_transactional_callbacks = true
  config.paperclip_defaults = {
    storage: :s3,
    bucket: ENV['S3_BUCKET_NAME'],
    s3_region: ENV['S3_REGION'],
    path: '/:class/:id/:style/:filename',
    url: ':s3_domain_url',
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
  }

  GA.tracker = ENV['GOOGLE_ANALYTICS']

  # Redis
  config.cache_store   = :redis_store, 'redis://store:6379/0/cache',   { expires_in: 90.minutes }
  config.session_store = :redis_store, 'redis://store:6379/0/session', { expires_in: 1.month }

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
