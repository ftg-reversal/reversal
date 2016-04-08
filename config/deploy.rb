lock '3.4.0'

set :application, 'ftg-reversal'
set :repo_url, 'git@github.com:ftg-reversal/reversal.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :rbenv_type, :user # :system or :user
set :rbenv_ruby, '2.3.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/ckeditor_assets')
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'Upload webpack files'
  task :webpack do
    on roles(:app) do |host|
      upload!('public/webpack', "#{shared_path}/public/", recursive: true)
    end
  end

  task :restart do
    invoke 'unicorn:reload'
  end

  before :starting, 'deploy:webpack'
  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end