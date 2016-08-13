# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  require 'ckeditor/orm/active_record'
  config.assets_languages = %w(ja en)
  config.assets_plugins = %w(autoembed autolink embed embedbase image2 imageresponsive lineutils notification notificationaggregator simpleuploads widget)
end

Rails.application.config.assets.precompile += %w(ckeditor/*)
