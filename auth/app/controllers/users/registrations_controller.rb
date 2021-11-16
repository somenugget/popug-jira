module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |user|
        EventsProducer.produce_sync(
          topic: 'users-stream',
          payload: {
            event_name: 'UserRegistered',
            **user.as_json(only: %i[public_id email first_name last_name role])
          }.to_json
        )
      end
    end
  end
end
