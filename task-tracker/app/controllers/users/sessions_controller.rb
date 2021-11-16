module Users
  class SessionsController < Devise::SessionsController
    layout 'auth'

    def new; end
  end
end
