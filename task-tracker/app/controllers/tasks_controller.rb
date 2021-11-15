class TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    task = Tasks::Create.new.call(task_attributes: task_attributes)
    Tasks::Assign.new.call(task: task, assignee: Users::GetRandomPopug.new.call)

    redirect_to tasks_path, flash: { success: 'New task had been created!' }
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    Tasks::Update.new.call(task: task, task_attributes: task_attributes)

    redirect_to tasks_path, flash: { success: 'Task had been updated!' }
  end

  def complete
    @task = Task.find(params[:id])

    # TODO: extract to service
    @task.update!(status: 'complete')
  end

  private

  def task_attributes
    params.require(:task).permit(:title, :description).to_h
  end
end
