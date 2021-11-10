class User < ApplicationRecord
  include HasPublicId

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
