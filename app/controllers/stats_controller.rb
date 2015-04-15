class StatsController < ApplicationController
  def json
    onlineTimeout = 10 # number of seconds a user is assumed to be online

    # The user requesting this statistics is also online  
    #UsersController.updateSession(session)

    # count then umber of users that have been active within the last 'onlineTimeout' seconds
    onlineUsers = User.where("lastActivityTime >= ?", Time.zone.now-onlineTimeout).count

    jsonMap = {};
    jsonMap["onlineUsers"]=onlineUsers;
    render json: jsonMap
  end
end
