module Tasks
  class Assign
    def initialize(task_assigned_event: Events::Tasks::TaskAssigned.new)
      @task_assigned_event = task_assigned_event
    end

    def call(task:, assignee:)
      task.update!(assignee: assignee)

      @task_assigned_event.produce(task_id: task.public_id, user_id: assignee.public_id)
    end
  end
end
