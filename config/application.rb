require File.expand_path('../boot', __FILE__)

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Reversal
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths.push "#{Rails.root}/app/configes"
    config.autoload_paths.push "#{Rails.root}/app/infrastructures"
    config.autoload_paths.push "#{Rails.root}/app/repositories"
    config.autoload_paths.push "#{Rails.root}/app/services"
    config.autoload_paths.push "#{Rails.root}/lib"

    config.generators.template_engine = :slim

    config.i18n.default_locale = :ja

    if ENV['RAILS_ENV'] == 'development'
      config.middleware.use Rack::ReverseProxy do
        reverse_proxy(%r{^/webpack/?(.*)/?$}, "http://localhost:3808/webpack/#{$1}")
      end
    end
  end
end
