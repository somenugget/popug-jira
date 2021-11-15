module Tasks
  class Delete
    def initialize(task_deleted_event: Events::TasksStream::TaskDeleted.new)
      @task_deleted_event = task_deleted_event
    end

    def call(task:)
      task.destroy!

      @task_deleted_event.produce({ task_id: task.public_id })
    end
  end
end
