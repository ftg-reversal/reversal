require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Reversal
  class Application < Rails::Application
    config.time_zone = 'Tokyo'

    config.autoload_paths.push "#{Rails.root}/lib"

    config.generators.template_engine = :slim
    config.generators.fixture_replacement :factory_girl, dir: 'spec/factory_girl'

    config.i18n.default_locale = :ja
  end
end
