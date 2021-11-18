module Tasks
  class Create
    def initialize(task_created_event: Events::TasksStream::TaskCreated.new)
      @task_created_event = task_created_event
    end

    def call(task_attributes:)
      Task.create!(task_attributes.merge(status: 'todo')).tap do |task|
        @task_created_event.produce(task.attributes.merge(task_id: task.public_id))
      end
    end
  end
end
