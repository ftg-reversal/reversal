require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/puma'
require 'capistrano/puma/nginx'   # if you want to upload a nginx site template
require 'whenever/capistrano'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
