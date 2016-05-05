source 'https://rubygems.org'
ruby '2.3.0'

# rails
gem 'rails', '~> 4.2'
gem 'therubyracer'

gem 'newrelic_rpm'

# DB
gem 'mysql2'
gem 'active_record_union'

gem 'foreman'

# View
gem 'turbolinks'
gem 'slim-rails'
gem 'active_model_serializers'
gem 'kaminari'
gem 'active_link_to'
gem 'rails_autolink'

# Decorator
gem 'draper'

# Service
gem 'twitter'
gem 'slack-api'
gem 'slack_markdown'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-slack'
gem 'aws-sdk', '>= 2.0.0'
gem 'nico_search_snapshot'
gem 'yt'
gem 'devise'
gem 'paperclip', git: 'https://github.com/thoughtbot/paperclip.git'
gem 'ckeditor'
gem 'gemoji'

# Production Manage
gem 'whenever', require: false
gem 'exception_notification'

# Util
gem 'classy_enum'

group :development, :test do
  gem 'thin'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'quiet_assets'
  gem 'dotenv-rails'

  # DB
  gem 'seed_dump'
  gem 'squasher'

  # Pry
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-doc'
  gem 'pry-coolline'
  gem 'awesome_print'
  gem 'hirb'
  gem 'hirb-unicode-steakknife', require: 'hirb-unicode'
  gem 'better_errors'
  gem 'binding_of_caller'

  # Visualization
  gem 'annotate'
  gem 'rails-erd'
  gem 'view_source_map'

  # CI
  gem 'bullet'
  gem 'rubocop', require: false, git: 'https://github.com/bbatsov/rubocop'
  gem 'rails_best_practices', require: false
  gem 'brakeman', require: false
  gem 'slim_lint', require: false
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'webmock'
  gem 'coderay'
end

group :production do
  gem 'unicorn'
  gem 'unicorn-worker-killer'
end

group :deployment do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn', git: 'https://github.com/tablexi/capistrano3-unicorn.git'
end
