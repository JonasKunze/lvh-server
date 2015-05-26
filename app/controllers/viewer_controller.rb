class ViewerController < ApplicationController
  
  layout 'viewer'

  before_action :update_session

  def index
  end

  def current_snippet    
    @current_snippet = Snippet.current
    @next_snippet = Snippet.next
    @rating_marks = RatingMark.all
  end

  private

    def update_session
      UsersController.updateSession(session)
    end
end
