class User < ActiveRecord::Base
  has_many :ratings

  def has_voted_for_snippet?(snippet_id)
    rating = Rating.find_by(user_id: self.id, snippet_id: snippet_id)
    rating ? true : false
  end
end
