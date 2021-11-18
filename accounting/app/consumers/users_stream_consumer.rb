class UsersStreamConsumer < ApplicationConsumer
  USER_ATTRIBUTES_TO_SYNC = %w[email first_name last_name role].freeze

  def consume
    messages.each do |message|
      case message.payload['event_name']
      when 'UserRegistered'
        User.create!(
          message
            .payload['payload']
            .slice(*USER_ATTRIBUTES_TO_SYNC)
            .merge(public_id: message.payload['payload']['user_id'])
        )
      when 'UserUpdated'
        User
          .find_by(public_id: message.payload['payload']['user_id'])
          &.update!(message.payload['payload'].slice(*USER_ATTRIBUTES_TO_SYNC))
      end
    end
  end
end
