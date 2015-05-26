class ViewerController < ApplicationController
  
  layout 'viewer'

  before_action :update_session

  def index
  end

  def current_snippet
    @current_snippet = Snippet.current
    if @user.has_voted_for_snippet?(@current_snippet)
      @current_snippet = nil
    end
    @next_snippet = Snippet.next
    @rating_marks = RatingMark.all
  end

  private

    def update_session
      @user = UsersController.updateSession(session)
    end
end
