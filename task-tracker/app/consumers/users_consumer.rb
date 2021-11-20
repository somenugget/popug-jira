class UsersConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      payload = message.payload['payload']
      event_name = message.payload['event_name']
      event_version = message.payload['event_version']

      case [event_name, event_version]
      when ['UserRoleChanged', 1]
        User.find_by(public_id: payload['user_id']).update!(role: payload['role'])
      end
    end
  end
end
