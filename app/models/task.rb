# frozen_string_literal: true

# Model Task
class Task < ApplicationRecord
  AVAILABLE_QUEUES = %w[critical scheduled default low].freeze

  before_create :auto_fill_name_if_nil,
                :delete_scheduled_at_if_needed
  after_create :schedule_task

  validate :cannot_be_done_to_cancel
  validates :queue_name, inclusion: { in: AVAILABLE_QUEUES,
                                      message: '%{value} queue not exists' }

  def auto_fill_name_if_nil
    self.name = "Task: #{Task.count + 1}" if name.blank?
  end

  def do!
    return false if canceled?
    return true if done?

    self.done_at = Time.now
    self.done = true
    save!
  end

  def cancel!
    return true if canceled?

    self.canceled = true
    save
  end

  def cannot_be_done_to_cancel
    errors[:base] << 'Cannot cancel, task is already done' if done? && canceled?
  end

  def delete_scheduled_at_if_needed
    self.scheduled_at = nil if queue_name != 'scheduled'
  end

  def schedule_task
    if queue_name == :scheduled
      ScheduledWorker.perform_at(scheduled_at, id)
    else
      TaskWorker.set(queue: queue_name).perform_async(id)
    end
  end
end
