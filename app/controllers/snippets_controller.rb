# coding: utf-8
class SnippetsController < ApplicationController

  def json
    # Register the session (update activity time)
    UsersController.updateSession(session)
    
    jsonMap = {}
    setting=Setting.getSetting()
    startTime=setting.startTime

    # Add available rating marks
    jsonMap['ratingmarks'] = RatingMarksController.getAvailableMarks

    snippets = {}
    Snippet.all.each{ # All snippets
      |snippet|
      hash = {};
      snippet.attributes.each{ |k,v| # All attributes of current snippet
        if k != "created_at" && k != "updated_at" && k != "showTime" && k != "id"
          hash[k] = v
        end
      }
      
      # Ratings as in "ratings":{ID:count}
      # here count means the number of users that have hit this button for the current snippet
      hash["ratings"] = {}
      snippet.rating_marks.each{ |ratingMark|
        result = snippet.getNumberOfRatings(ratingMark)
        hash["ratings"][ratingMark.id]=result;
      }

      timeRemaining = (startTime - Time.zone.now + snippet.showTime).round
      #      timeRemaining = -1 if timeRemaining < 0,
        hash["timeRemaining"]=timeRemaining

      jsonMap[snippet.id]=hash

    }
    jsonMap['snippets'] = snippets;
    render json: jsonMap
  end

  def json2
    # Register the session (update activity time)
    UsersController.updateSession(session)
    
    json_data = {}
    json_data['snippets'] = []
    json_data['ratingmarks'] = RatingMarksController.getAvailableMarks

    Snippet.order('showTime ASC').each do |snippet|
      hash = {};
      snippet.attributes.each{ |k,v| hash[k] = v if k != "created_at" && k != "updated_at" && k != "showTime" }
      hash["timeRemaining"] = snippet.time_remaining
      
      # Ratings as in "ratings":{ID:count}
      # here count means the number of users that have hit this button for the current snippet
      hash["ratings"] = {}
      snippet.rating_marks.each do |ratingMark|
        hash["ratings"][ratingMark.id] = snippet.getNumberOfRatings(ratingMark)
      end

      json_data['snippets'] << hash
    end
    
    #json_data['snippets'].sort_by!{ |snippet| snippet['timeRemaining'] }

    # Get current and next snippet
    # json_data['nextSnippet'] = json_data['currentSnippet'] = json_data['snippets'].last
    # json_data['snippets'].each do |snippet|
    #   if snippet['timeRemaining'] > 0 && snippet['timeRemaining'] < json_data['nextSnippet']['timeRemaining']
    #     json_data['nextSnippet'] = snippet
    #   elsif snippet['timeRemaining'] <= 0 && snippet['timeRemaining'] > json_data['currentSnippet']['timeRemaining']
    #     json_data['currentSnippet'] = snippet
    #   end
    # end

    render json: json_data
  end

  def index
    @snippets = Snippet.all
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def time_remaining
    @snippet = Snippet.find(params[:id])
    respond_to do |format| 
      format.json { render json: @snippet.time_remaining  }
    end
  end

  def new
    @snippet = Snippet.new
    @rating_marks = RatingMark.all
  end

  def edit
    @snippet = Snippet.find(params[:id])
    @rating_marks = RatingMark.all
  end

  def create
    @snippet = Snippet.new(snippet_params)
    #    @snippet.showTime = snippet_params[:showTime].to_i
    if @snippet.save
      redirect_to @snippet
    else
      render 'new'
    end
  end

  def update
    @snippet = Snippet.find(params[:id])
    @rating_marks = RatingMark.all

    if (params[:rating_marks])
      puts "===================="
      @snippet.rating_marks.clear
      params[:rating_marks].each{ |mark,id|
        puts id
        @snippet.rating_marks << RatingMark.find(id)
      }
    end
    if @snippet.update(snippet_params)
      redirect_to @snippet
    else
      render 'edit'
    end
  end

  def destroy
    @snippet = Snippet.find(params[:id])
    @snippet.destroy

    redirect_to snippets_path
  end

  private

  def snippet_params
    params[:snippet].permit(:french, :german, :showTime)
  end
end
