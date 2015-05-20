class ViewerController < ApplicationController
  
  layout 'viewer'

  before_action :update_session

  def index
    @snippets = Snippet.order('showTime ASC')
    @rating_marks = RatingMarksController.getAvailableMarks    
  end

  private

    def next_snippet
      
    end

    def update_session
      UsersController.updateSession(session)
    end
end
