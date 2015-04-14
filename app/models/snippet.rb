class Snippet < ActiveRecord::Base
  has_and_belongs_to_many :rating_marks
  has_many :ratings

  def getNumberOfRatings(ratingMarkID)
    return Rating.where({snippet_id: self.id, rating_mark_id: ratingMarkID}).count
  end
end
