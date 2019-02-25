# frozen_string_literal: true

require 'test_helper'
require 'sidekiq/testing'
class TaskTest < ActiveSupport::TestCase
  test 'should auto fill the name if blank before create' do
    task = Task.create
    assert_not task.name.blank?
  end

  test 'should mask as done' do
    task = Task.create
    task.do!
    assert_not_nil task.done_at
    assert task.done?
  end

  test 'should not cancel if task is done' do
    task = Task.new done: true
    assert_not task.cancel!
  end

  test 'should not save if queue_name not exists' do
    task = Task.new queue_name: :nonexistent_queue
    assert_not task.save
    assert_not_empty task.errors[:queue_name]
  end

  test 'should set nil to scheduled_at if queue_name is not scheduled' do
    task = Task.new queue_name: :default
    task.scheduled_at = Time.now
    assert task.save
    assert_nil task.scheduled_at
  end

  test 'should scheduled task using ScheduleWorker' do
    task = Task.create queue_name: :scheduled,
                       scheduled_at: (Time.now + 1.day)
    assert_not task.new_record?
    task.schedule_task
    assert_not Sidekiq::Queues['scheduled'].empty?
  end

  test 'should scheduled task using TaskWorker' do
    task = Task.create queue_name: :low
    assert_not task.new_record?
    task.schedule_task
    assert_not Sidekiq::Queues['low'].empty?
  end
end
