# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  require "ckeditor/orm/active_record"
  config.assets_languages = ['ja', 'en']
end
