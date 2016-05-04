lock '3.5.0'

set :application, 'ftg-reversal'
set :repo_url, 'git@github.com:ftg-reversal/reversal.git'

set :branch, fetch(:branch, 'master')

set :rbenv_type, :user # :system or :user
set :rbenv_ruby, '2.3.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/webpack', 'public/system', 'public/ckeditor_assets')

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_roles, -> { :batch }

namespace :deploy do
  desc 'Compile and Upload webpack files'
  task :webpack do
    run_locally do
      info 'Webpack Compile...'
      execute 'rm public/webpack/*; env TARGET=production node_modules/.bin/webpack --config config/webpack.config.js'
    end
    on roles(:app) do |host|
      upload!('public/webpack', "#{shared_path}/public/", recursive: true)
    end
  end
end

before 'deploy:starting', 'deploy:webpack'
after 'deploy:publishing', 'unicorn:restart'
