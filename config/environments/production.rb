require 'unicorn/worker_killer'
use Unicorn::WorkerKiller::MaxRequests, 3072, 4096
use Unicorn::WorkerKiller::Oom, (192*(1024**2)), (256*(1024**2))

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  # config.assets.js_compressor = :uglifier
  # configs.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true
  config.log_level = :debug

  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false

  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  config.active_record.raise_in_transactional_callbacks = true
  config.paperclip_defaults = {
    storage: :s3,
    bucket: ENV['S3_BUCKET_NAME'],
    s3_region: ENV['S3_REGION'],
    path: "/:class/:id/:style/:filename",
    url: ':s3_domain_url',
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
  }
end
