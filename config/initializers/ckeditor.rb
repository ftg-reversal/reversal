# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  require "ckeditor/orm/active_record"
  config.assets_languages = ['ja', 'en']
  config.assets_plugins = ['simpleuploads', 'embed', 'autoembed', 'justify', 'imageresponsive', 'colorbutton']
end
