# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = if Rails.env.production?
                   { size: 1 }
                 else
                   { url: Rails.application.secrets[:redis_provider] }
                 end
end

Sidekiq.configure_client do |config|
  config.redis = if Rails.env.production?
                   { size: 5 }
                 else
                   { url: Rails.application.secrets[:redis_provider] }
                 end
end
