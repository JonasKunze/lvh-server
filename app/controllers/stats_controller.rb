class StatsController < ApplicationController
  def index
  end

  def json

    # The user requesting this statistics is also online?!
    #UsersController.updateSession(session)

    jsonMap = {}
    jsonMap["onlineUsers"] = countOnlineUsers()

    # Set available rating marks counters to 0
      ratingMarks = {};
    RatingMark.all.each{ # All snippets
        |ratingMark|
      ratingMarks[ratingMark.id] =  Rating.where({rating_mark_id: ratingMark.id}).count;
    }

    jsonMap['ratingmarks'] = ratingMarks

    # Print the json
    render json: jsonMap

  end

  def countOnlineUsers
    onlineTimeout = 30 # number of seconds a user is assumed to be online

    # count the number of users that have been active within the last 'onlineTimeout' seconds
   User.where("lastActivityTime >= ?", Time.zone.now-onlineTimeout).count
  end
end
