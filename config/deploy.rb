lock '3.6.0'

set :application, 'ftg-reversal'
set :repo_url, 'git@github.com:ftg-reversal/reversal.git'

set :branch, fetch(:branch, 'master')

set :rbenv_type, :user # :system or :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/webpack', 'public/system', 'public/ckeditor_assets')

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_roles, -> { :batch }

namespace :deploy do
  desc 'Compile and Upload webpack files'
  before :compile_assets, :compile_webpack do
    run_locally do
      info 'Webpack Compile...'
      execute 'rm app/assets/javascripts/webpack/*; rm app/assets/stylesheets/webpack/*; npm run build:production'
    end
    on roles(:web) do |_|
      upload!('app/assets/javascripts/webpack', "#{release_path}/app/assets/javascripts/webpack", recursive: true)
      upload!('app/assets/stylesheets/webpack', "#{release_path}/app/assets/stylesheets/webpack", recursive: true)
    end
  end

  desc 'Migrate ridgepole'
  after :published, :ridgepole do
    on roles(:db) do
      execute "/bin/bash -l -c 'cd #{fetch(:release_path)}; env RAILS_ENV=production bin/rake db:migrate'"
    end
  end
end

after 'deploy:publishing', 'unicorn:restart'
