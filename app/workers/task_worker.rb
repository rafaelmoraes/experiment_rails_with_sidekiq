# frozen_string_literal: true

# TaskWorker - Sidekiq::Worker
class TaskWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(task_id)
    task = Task.find_by id: task_id
    sleep 45 if Rails.env.development?
    task&.do!
  end
end
