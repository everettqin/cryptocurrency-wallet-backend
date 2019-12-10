Sidekiq.options[:max_retries] = 0

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_SIDEKIQ_HOST']}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_SIDEKIQ_HOST']}" }
end