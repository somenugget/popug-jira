class TasksController < ApplicationController
  before_action :authenticate_user!

  helper_method :my_tasks_only?

  def index
    @tasks = Tasks::List.new.call(user: my_tasks_only? ? current_user : nil)
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
    Tasks::Complete.new.call(task: Task.find(params[:id]))
  end

  def reassign
    Tasks::Reassign.new.call

    redirect_to request.referrer
  end

  private

  def my_tasks_only?
    request.path.include?('/my')
  end

  def task_attributes
    params.require(:task).permit(:title, :description).to_h
  end
end
