class RatingsController < ApplicationController

  before_action :get_user, only: [:create]

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
    @snippet = Snippet.find(params[:snippet_id])
    #@rating = Rating.take({:snippet_id => @snippet.id, :user_id => @user.id }) rescue nil
    @rating = Rating.where({:snippet_id => @snippet.id, :user_id => @user.id }).take
    puts "Snippet:"
    puts @snippet.inspect
    puts "Rating:"
    puts @rating.inspect
    puts "User ID:" 
    puts @user.id
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!"
 
    dataHash = rating_params.merge({:user_id => @user.id})
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

    respond_to do |format|
      format.html {
        if success
          redirect_to @rating
        else
          render 'new'
        end        
      }
      format.js { }
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

    def get_user
      @user = UsersController.getSessionUser(session)
    end
end
