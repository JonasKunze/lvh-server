class RatingMarksController < ApplicationController

  before_action :authenticate, only: [:index, :show, :new, :edit, :create]

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

 def self.getAvailableMarks
   # Available rating marks
   ratingMarks = {};
   RatingMark.all.each{ # All snippets
       |ratingMark|
     ratingMarks[ratingMark.id] = ratingMark.title;
   }

   return ratingMarks
 end
 
  private
    def rating_mark_params
      params.require(:rating_mark).permit(:title, :explanation)
    end
end
