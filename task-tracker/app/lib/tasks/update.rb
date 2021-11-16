module Tasks
  class Update
    def initialize(task_updated_event: Events::TasksStream::TaskUpdated.new)
      @task_updated_event = task_updated_event
    end

    def call(task:, task_attributes:)
      task.update!(task_attributes)

      @task_updated_event.produce(
        task_id: task.public_id,
        title: task.title,
        description: task.description
      )
    end
  end
end
