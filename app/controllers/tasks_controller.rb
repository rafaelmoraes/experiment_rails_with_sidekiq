# frozen_string_literal: true

# TasksController
class TasksController < ApplicationController
  before_action :set_task, only: %i[cancel destroy]

  def index
    @tasks = Task.all
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_url, notice: 'Task was successfully created.'
    else
      render :index
    end
  end

  def cancel
    if @task&.cancel!
      redirect_to root_url, notice: 'Task was successfully canceled'
    else
      render :index
    end
  end

  def destroy
    if @task&.delete
      redirect_to root_url, notice: 'Task was successfully deleted'
    else
      render :index
    end
  end

  def destroy_all
    if Task.delete_all
      redirect_to root_url, notice: 'All tasks was successfully deleted'
    else
      render :index
    end
  end

  private

  def task_params
    params.fetch(:task).permit(:name, :queue_name, :scheduled_at)
  end

  def set_task
    @task = Task.find_by id: params[:id]
  end
end
