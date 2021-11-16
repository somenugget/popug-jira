module Tasks
  class Complete
    def initialize(task_completed_event: Events::Tasks::TaskCompleted.new)
      @task_completed_event = task_completed_event
    end

    def call(task:)
      task.update!(status: 'completed')

      @task_completed_event.produce(task_id: task.public_id)
    end
  end
end
