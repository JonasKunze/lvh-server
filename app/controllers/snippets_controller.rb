# coding: utf-8
class SnippetsController < ApplicationController
  def json
    map = {}
    setting=Setting.getSetting()
    startTime=setting.startTime
    
    Snippet.all.each{ # All snippets
      |snippet|
        hash = {};
      snippet.attributes.each{ |k,v| # All attributes of current snippet
        if k != "created_at" && k != "updated_at" && k != "showTime" && k != "id"
          hash[k] = v
        end
      }
      # Ratings as in "ratings":{"1":{"title":"button1", "count":"0"}{}}
      # here count means the number of users that have hit this button for the current snippet
      hash["ratings"] = {}
      snippet.rating_marks.each{ |ratingMark|
        #        result = Rating.count({snippet_id: snippet.id, rating_mark_id: ratingMark})
        result = snippet.getNumberOfRatings(ratingMark)
        hash["ratings"][ratingMark.id]={"title" => ratingMark.title, "count" => result}
      }
      
      timeRemaining = (startTime - Time.zone.now + snippet.showTime).round
      #      timeRemaining = -1 if timeRemaining < 0,

        hash["timeRemaining"]=timeRemaining

      map[snippet.id]=hash
    }
    render json: map
  end
  
  def index
    @snippets = Snippet.all
  end
  
  def show
    @snippet = Snippet.find(params[:id])
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
      params[:snippet].permit(:french, :german, :showTime, rating_marks: [])
    end
end
