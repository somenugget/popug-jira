# https://github.com/sinatra/sinatra/issues/1616
class OmniAuthTokenVerifier
  include ActiveSupport::Configurable
  include ActionController::RequestForgeryProtection

  def call(env)
    @request = ActionDispatch::Request.new(env.dup)
    raise OmniAuth::AuthenticityError unless verified_request?
  end

  private

  attr_reader :request

  delegate :params, :session, to: :request
end
