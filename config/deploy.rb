lock '3.6.1'

set :application, 'ftg-reversal'
set :repo_url, 'git@github.com:ftg-reversal/reversal.git'

set :branch, fetch(:branch, 'master')

set :rbenv_type, :user # :system or :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value

# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
# set :puma_preload_app, true
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/webpack', 'public/system', 'public/ckeditor_assets')

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_roles, -> { :batch }

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end
#
#   desc 'Upload puma production settings file'
#   task :upload_settings do
#     on roles(:app) do |_|
#       upload!('config/puma/production.rb', "#{shared_path}/puma.rb")
#     end
#   end
#
#   before :start, :make_dirs
#   before :check, :upload_settings
# end

namespace :deploy do
  desc 'Compile and Upload webpack files'
  before :compile_assets, :compile_webpack do
    run_locally do
      info 'Webpack Compile...'
      execute 'rm app/assets/javascripts/webpack/*; rm app/assets/stylesheets/webpack/*; npm run build:production'
    end
    on roles(:app) do |_|
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

  desc 'Restart application'
  after :publishing, :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end
end
