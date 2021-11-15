module Users
  class GetRandomPopug
    def call
      User.find(User.where(role: 'popug').pluck(:id).sample)
    end
  end
end
