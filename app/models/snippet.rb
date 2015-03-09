class Snippet < ActiveRecord::Base
  has_and_belongs_to_many :rating_marks
  has_many :ratings

  def getNumberOfRatings(ratingMarkID)
    return Rating.count({snippet_id: id, rating_mark_id: ratingMarkID})
  end
end
