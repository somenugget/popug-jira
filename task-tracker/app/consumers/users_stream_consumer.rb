class UsersStreamConsumer < ApplicationConsumer
  USER_ATTRIBUTES_TO_SYNC = %w[email public_id first_name last_name role].freeze

  def consume
    messages.each do |message|
      case message.payload['event_name']
      when 'UserRegistered'
        User.create!(message.payload.slice(*USER_ATTRIBUTES_TO_SYNC))
      when 'UserUpdated'
        User
          .find_by(public_id: message.payload['public_id'])
          &.update!(message.payload.slice(*USER_ATTRIBUTES_TO_SYNC))
      end
    end
  end
end
