class ViewerController < ApplicationController
  
  layout 'viewer'

  before_action :update_session
  before_action :authenticate, only: [:prev_snippet, :next_snippet]

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

  def prev_snippet
    snippet_id = params[:snippet_id].to_i
    @current_snippet = Snippet.find_by(id: snippet_id - 1) || Snippet.find_by(id: snippet_id)
    @next_smippet = Snippet.find(snippet_id)
    @rating_marks = RatingMark.all
    render 'snippet'
  end

  def next_snippet
    snippet_id = params[:snippet_id].to_i
    @current_snippet = Snippet.find_by(id: snippet_id + 1) || Snippet.find_by(id: snippet_id)
    @next_snippet = Snippet.find_by(id: snippet_id + 2) || @current_snippet
    @rating_marks = RatingMark.all
    render 'snippet'
  end

  private

    def update_session
      @user = UsersController.updateSession(session)
    end
end
