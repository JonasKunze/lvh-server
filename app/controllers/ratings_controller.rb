class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end
  
  def show
    @rating = Rating.find(params[:id])
  end

  def new
    @rating = Rating.new
  end

  def edit
    @rating = Rating.find(params[:id])
  end
  
  def create
    sessionUser = UsersController.getSessionUser(session)
    @snippet = Snippet.find(params[:snippet_id])
    @rating = Rating.find({:snippet_id => @snippet.id, :user_id => sessionUser.id }) rescue nil

    dataHash = rating_params.merge({:user_id => sessionUser.id})
    sucess = false
    if @rating
      if @rating.update(dataHash)
        success = true
      end
    else
      @rating = @snippet.ratings.create(dataHash)
      if @rating.save
        success = true
      end
    end
    
    if success
      redirect_to @rating
    else
      render 'new'
    end
  end
  
  def update
    @rating = Rating.find(params[:id])
    
    if @rating.update(rating_params)
      redirect_to @rating
    else
      render 'edit'
    end
  end
  
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
    
    redirect_to ratings_path
  end
  
  private
    def rating_params
      params.require(:rating).permit(:rating_mark_id, :snippet_id)
    end
end
