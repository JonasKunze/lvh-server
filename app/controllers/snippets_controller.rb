class SnippetsController < ApplicationController
  def json
    map = {}
    
    Snippet.all.each{ # All snippets
      |snippet|
      hash = {};
      snippet.attributes.each{ |k,v| # All attributes of current snippet
        if k != "created_at" && k != "updated_at" && k != "showTimeOffset"
          hash[k] = v
        end
      }
      hash["ratings"] = {}
     snippet.ratings.each{ |r|
        hash["ratings"][r.rating_mark.id]=r.rating_mark.attributes.title
      }
      
      map[snippet.showTimeOffset]=hash
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
  end

  def edit
    @snippet = Snippet.find(params[:id])
  end
  
  def create
    @snippet = Snippet.new(snippet_params)

    if @snippet.save
      redirect_to @snippet
    else
      render 'new'
    end
  end
  
  def update
    @snippet = Snippet.find(params[:id])
    
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
      params[:snippet].permit(:french, :german, :showTimeOffset)
    end
end
