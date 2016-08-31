ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../config/environment', File.dirname(__FILE__))
require 'rspec/rails'
require 'pry-rails'

ActiveRecord::Migration.maintain_test_schema!

FactoryGirl.definition_file_paths = [Rails.root.join('spec', 'factory_girl')]
FactoryGirl.find_definitions

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, '../', file))
end

RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec', 'fixtures', 'models')
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
end
