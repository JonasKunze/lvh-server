class ViewerController < ApplicationController
  
  layout 'viewer'

  before_action :update_session

  def index
  end

  def current_snippet    
    @current_snippet = Snippet.current
  end

  private

    def next_snippet
      
    end

    def update_session
      UsersController.updateSession(session)
    end
end
