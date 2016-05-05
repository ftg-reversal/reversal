# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  require "ckeditor/orm/active_record"
  config.assets_languages = ['ja', 'en']
  config.assets_plugins = ['autoembed', 'autolink', 'embed', 'embedbase', 'image2', 'imageresponsive', 'lineutils', 'notification', 'notificationaggregator', 'simpleuploads', 'widget']
end
