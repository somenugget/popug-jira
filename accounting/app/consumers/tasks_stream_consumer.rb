class TasksStreamConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      case message.payload['event_name']
      when 'TaskCreated'
        next if message.payload['task_id'].blank?

        Task.create!(
          public_id: message.payload['task_id'],
          title: message.payload['title']
        )

      when 'TaskUpdated'
        pp message.payload
        Task
          .find_by(public_id: message.payload['payload']['task_id'])
          .update!(title: message.payload['title'], description: message.payload['description'])
      when 'TaskDeleted'
        puts 'TaskDeleted'
      end

    rescue StandardError
      next
    end
  end
end
