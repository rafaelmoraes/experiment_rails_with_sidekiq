# frozen_string_literal: true

require 'test_helper'
class ScheduledWorkerTest < MiniTest::Test
  def test_perform_method
    work = ScheduledWorker.new
    task = Task.create scheduled_at: (Time.now + 1.second),
                       queue_name: 'scheduled'
    refute task.done?
    work.perform(task.id)
    task.reload
    assert task.done?
  end
end
