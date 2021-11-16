module Tasks
  class Reassign
    def initialize(
      task_assigned_event: Events::Tasks::TaskAssigned.new,
      get_random_popug: Users::GetRandomPopug.new
    )
      @task_assigned_event = task_assigned_event
      @get_random_popug = get_random_popug
    end

    def call
      Task.where(status: 'todo').find_each do |task|
        assignee = @get_random_popug.call

        task.update!(assignee: assignee)

        @task_assigned_event.produce(task_id: task.public_id, user_id: assignee.public_id)
      end
    end
  end
end
