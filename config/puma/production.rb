#!/usr/bin/env puma

directory '/home/ec2-user/apps/reversal/current'
rackup '/home/ec2-user/apps/reversal/current/config.ru'
environment 'production'

pidfile '/home/ec2-user/apps/reversal/shared/tmp/pids/puma.pid'
state_path '/home/ec2-user/apps/reversal/shared/tmp/pids/puma.state'
stdout_redirect '/home/ec2-user/apps/reversal/current/log/puma.error.log', '/home/ec2-user/apps/reversal/current/log/puma.access.log', true


threads 0, 16

bind 'unix:///home/ec2-user/apps/reversal/shared/tmp/sockets/puma.sock'

workers 0

preload_app!

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/ec2-user/apps/reversal/current/Gemfile"
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
