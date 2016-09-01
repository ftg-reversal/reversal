require 'factory_girl'
require 'webmock/rspec'
require 'simplecov'

FactoryGirl.definition_file_paths = [File.expand_path('../factory_girl', __FILE__)]

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
