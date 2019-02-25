# frozen_string_literal: true

require 'application_system_test_case'

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test 'visiting the index' do
    visit root_url
    assert_selector 'h1', text: 'Tasks'
  end

  test 'creating a Task' do
    visit root_url

    fill_in 'Name', with: 'Task from system test'
    select Time.now.tomorrow.day.to_s, from: 'task_scheduled_at_3i'
    select 'scheduled', from: 'task_queue_name'
    click_on 'Create Task'

    assert_text 'Task was successfully created'
  end

  test 'canceling a Task' do
    visit root_url
    click_link 'Cancel', match: :first

    assert_text 'Task was successfully canceled'
  end

  test 'destroying a Task' do
    visit root_url
    page.accept_confirm do
      click_link 'Delete', match: :first
    end
    assert_selector('#notice', text: 'Task was successfully deleted')
  end

  test 'destroying all Tasks' do
    visit root_url
    page.accept_confirm do
      click_on 'Delete All Tasks', match: :prefer_exact
    end
    assert_selector('#notice', text: 'All tasks was successfully deleted')
  end
end
