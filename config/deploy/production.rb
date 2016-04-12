set :user, 'ec2-user'
set :rails_env, 'production'
set :deploy_to, "/home/#{fetch(:user)}/apps/reversal"
set :deploy_via, :remote_cache
set :use_sudo, false

server 'ftg-reversal.net',
  roles: [:web, :app],
  port: fetch(:port),
  user: fetch(:user),
  primary: true


set :ssh_options, {
  keys: '~/.ssh/reversal.pem',
  forward_agent: true,
  auth_methods: %w(publickey),
  user: 'ec2-user',
}

set :rails_env, :production
set :conditionally_migrate, true
