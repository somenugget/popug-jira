class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def auth
    user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect user
  end

  private

  def after_omniauth_failure_path_for
    '/'
  end
end
