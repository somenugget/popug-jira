class User < ApplicationRecord
  devise :omniauthable

  has_many :tasks, foreign_key: :assignee_id

  # TODO: Оставляю создание тут пока нет стриминга пользователей из auth
  # потом будет просто поиск по provider и uid
  def self.from_omniauth(auth)
    User.find_or_initialize_by(provider: auth.provider, uid: auth.uid).tap do |user|
      user.update!(
        email: auth.info.email,
        public_id: auth.info.public_id,
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        role: auth.info.role
      )
    end
  end
end
