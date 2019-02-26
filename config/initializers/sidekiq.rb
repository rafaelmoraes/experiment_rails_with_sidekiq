# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { size: 1, url: Rails.application.secrets[:redis_provider] }
end

Sidekiq.configure_client do |config|
  config.redis = { size: 5, url: Rails.application.secrets[:redis_provider] }
end
