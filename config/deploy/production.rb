set :user, 'ec2-user'
set :rails_env, 'production'
set :deploy_to, "/home/#{fetch(:user)}/apps/reversal"
set :deploy_via, :remote_cache
set :use_sudo, false

# capistrano3-unicorn.rbの中で
# set :unicorn_rack_env, -> { fetch(:rails_env) == "development" ? "development" : "deployment" }
# execute :bundle, "exec unicorn", "-c", fetch(:unicorn_config_path), "-E", fetch(:unicorn_rack_env), "-D", fetch(:unicorn_options)
# されてるから仕方なく指定、ちょっと辛い
set :unicorn_rack_env, 'production'

# set :puma_conf,       "#{shared_path}/puma.rb"
# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :puma_preload_app, true
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true

server 'web.ftg-reversal.net',
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true

server 'batch.ftg-reversal.net',
  roles: [:batch],
  port: fetch(:port),
  user: fetch(:user),
  primary: true

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: 'ec2-user'
}

set :rails_env, :production
set :conditionally_migrate, true
