ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../config/environment', File.dirname(__FILE__))
require 'rspec/rails'
require 'pry-rails'
require 'factory_girl_rails'

FactoryGirl.definition_file_paths = [File.expand_path('../factory_girl', __FILE__)]

ActiveRecord::Migration.maintain_test_schema!

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, '../', file))
end

RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec', 'fixtures', 'models')
  config.use_transactional_fixtures = true

  config.include FactoryGirl::Syntax::Methods
  config.before(:all) do
    FactoryGirl.reload
  end
end
