if ENV['RAILS_ENV'] == 'production'
  require 'unicorn/worker_killer'
  use Unicorn::WorkerKiller::MaxRequests, 3072, 4096, 5120
  use Unicorn::WorkerKiller::Oom, (192 * (1024**2)), (256 * (1024**2)), (320 * (1024**2))
end

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
