Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_ENDPOINT_URI'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_ENDPOINT_URI'] }
end