class RatingMarksController < ApplicationController
 def index
    @rating_marks = RatingMark.all
  end
  
  def show
    @rating_mark= RatingMark.find(params[:id])
  end

  def new
    @rating_mark= RatingMark.new
  end

  def edit
    @rating_mark= RatingMark.find(params[:id])
  end
  
  def create
    @rating_mark= RatingMark.new(rating_mark_params)

    if @rating_mark.save
      redirect_to @rating_mark
    else
      render 'new'
    end
  end
 
  private
    def rating_mark_params
      params.require(:rating_mark).permit(:title)
    end
end
