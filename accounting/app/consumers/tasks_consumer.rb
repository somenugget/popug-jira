class TasksConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      case message.payload['event_name']
      when 'TaskAssigned'
        pp message.payload
        Task.find_by(public_id: message.payload['payload']['task_id']).update!(assignee_id: message.payload['task_id'])
      end
    rescue StandardError
      next
    end
  end
end
