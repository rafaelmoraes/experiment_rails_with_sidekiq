# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://rails_with_sidekiq_redis_1:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://rails_with_sidekiq_redis_1:6379/0' }
end
