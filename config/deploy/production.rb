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

server 'ftg-reversal.net',
  roles: [:web, :app, :db, :batch],
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
