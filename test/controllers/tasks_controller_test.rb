# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { name: '' } }
    end

    assert_redirected_to root_url
  end

  test 'should cancel task' do
    patch cancel_task_url(@task)

    assert_redirected_to root_url
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end
    assert_redirected_to root_url
  end

  test 'should destroy all tasks' do
    assert_difference('Task.count', -Task.count) do
      post tasks_destroy_all_url
    end
    assert_redirected_to root_url
  end
end
