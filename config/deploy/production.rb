set :user, 'ec2-user'
set :deploy_to, "/home/#{fetch(:user)}/apps/reversal"
set :deploy_via, :remote_cache
set :use_sudo, false

server 'ftg-reversal.net',
  roles: [:web, :app],
  port: fetch(:port),
  user: fetch(:user),
  primary: true


set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(~/.ssh/reversal.pem),
  user: 'ec2-user',
}

set :rails_env, :production
set :conditionally_migrate, true
