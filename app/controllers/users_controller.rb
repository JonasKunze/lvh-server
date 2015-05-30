class UsersController < ApplicationController

  before_action :authenticate, only: [:index, :show, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  def self.getSessionUser(session)
    user ||= session[:current_user_id] &&
    User.find_by(id: session[:current_user_id])

    if !user
      user = User.new()
      user.save
      session[:current_user_id] = user.id
    end
    
    user.lastActivityTime = Time.zone.now
    user.save
    
    user
  end

  def self.updateSession(session)
    user = getSessionUser(session)
  end

  private

  def user_params
    params.require(:user).permit(:sessionID)
  end
end
