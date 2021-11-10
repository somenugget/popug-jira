class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def current
    respond_to do |format|
      format.json { render json: current_user }
    end
  end
end
