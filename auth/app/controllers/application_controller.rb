class ApplicationController < ActionController::Base
  def current_user
    if doorkeeper_token
      User.find(doorkeeper_token.resource_owner_id)
    else
      super
    end
  end

  def authenticate_user!
    if doorkeeper_token
      doorkeeper_authorize!
    else
      super
    end
  end
end
