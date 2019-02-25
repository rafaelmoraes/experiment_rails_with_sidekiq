# frozen_string_literal: true

require 'test_helper'
class TaskWorkerTest < Minitest::Test
  def test_perform_method
    work = TaskWorker.new
    task = Task.create
    refute task.done?
    work.perform(task.id)
    task.reload
    assert task.done?
  end
end
