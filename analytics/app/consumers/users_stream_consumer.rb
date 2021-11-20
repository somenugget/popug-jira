class UsersStreamConsumer < ApplicationConsumer
  USER_ATTRIBUTES_TO_SYNC = %w[email first_name last_name role].freeze

  def consume
    messages.each do |message|
      payload = message.payload['payload']

      case message.payload['event_name']
      when 'UserRegistered'
        User.create!(
          payload
            .slice(*USER_ATTRIBUTES_TO_SYNC)
            .merge(public_id: payload['user_id'])
        )
      end
    end
  end
end
