shared_path = '/home/ec2-user/apps/reversal/shared/'

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

state_path File.expand_path('tmp/pids/puma.state', shared_path)
pidfile File.expand_path('tmp/pids/puma.pid', shared_path)
bind File.expand_path('tmp/sockets/puma.sock', shared_path)

worker_processes 2

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
