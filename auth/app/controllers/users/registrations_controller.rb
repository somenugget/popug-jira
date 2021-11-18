module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      User.transaction do
        super do |user|
          Events::UsersStream::UserRegistered.new.produce(
            **user.as_json(only: %i[email first_name last_name role]),
            user_id: user.public_id
          )
        end
      end
    end
  end
end
