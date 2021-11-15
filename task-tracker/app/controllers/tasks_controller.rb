class TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    Task.create!(task_params)

    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description).to_h
  end
end
