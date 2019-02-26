# frozen_string_literal: true

# Sidekiq Worker to process the scheduled tasks
class ScheduledWorker
  include Sidekiq::Worker
  sidekiq_options queue: :scheduled

  def perform(task_id)
    task = Task.find_by id: task_id
    sleep 90 if Rails.env.development?
    task&.do!
  end
end
