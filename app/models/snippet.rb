class Snippet < ActiveRecord::Base
  has_and_belongs_to_many :rating_marks
  has_many :ratings

  def getNumberOfRatings(ratingMarkID)
    return Rating.where({snippet_id: self.id, rating_mark_id: ratingMarkID}).count
  end

  def time_remaining
    (Setting.getSetting().startTime - Time.zone.now + self.showTime).round
  end

  def self.current
    snippets = Snippet.order('showTime ASC')
    current_snippet = snippets.last
    snippets.each{ |snippet| current_snippet = snippet if snippet.time_remaining < current_snippet.time_remaining  }
    current_snippet
  end

  def self.next
    
  end

end
