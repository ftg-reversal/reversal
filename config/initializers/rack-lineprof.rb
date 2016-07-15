if Rails.env == 'development'
  Reversal::Application.config.middleware.use Rack::Lineprof
end
