class StatsController < ApplicationController
  def json
    onlineTimeout = 60 # number of seconds a user is assumed to be online
  
    UsersController.updateSession(session)

    onlineUsers = User.where("lastActivityTime >= ?", Time.zone.now-onlineTimeout).count

    jsonMap = {};
    jsonMap["onlineUsers"]=onlineUsers;
    render json: jsonMap
  end
end
