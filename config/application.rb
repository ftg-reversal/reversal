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
    config.time_zone = 'Tokyo'

    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths.push "#{Rails.root}/app/factories"
    config.autoload_paths.push "#{Rails.root}/app/infrastructures"
    config.autoload_paths.push "#{Rails.root}/app/notifiers"
    config.autoload_paths.push "#{Rails.root}/app/parameters"
    config.autoload_paths.push "#{Rails.root}/app/repositories"
    config.autoload_paths.push "#{Rails.root}/app/services"
    config.autoload_paths.push "#{Rails.root}/lib"

    config.generators.template_engine = :slim

    config.i18n.default_locale = :ja

    # config.react.server_renderer_pool_size ||= 8
    # config.react.server_renderer_timeout   ||= 20
    # config.react.server_renderer = React::ServerRendering::SprocketsRenderer
    # config.react.server_renderer_options = {
    #   files: ['react-server.js', 'webpack/components.js'],
    #   replay_console: true
    # }
  end
end
