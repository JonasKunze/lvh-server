class Snippet < ActiveRecord::Base
  has_and_belongs_to_many :rating_marks
  has_many :ratings

  def getNumberOfRatings(ratingMarkID)
    return Rating.where({snippet_id: self.id, rating_mark_id: ratingMarkID}).count
  end

  def time_remaining
    show_time = self.showTime.nil? ? 0 : self.showTime
    (Setting.getSetting().startTime - Time.zone.now + show_time).round
  end

  def self.current
    snippets = Snippet.order('showTime ASC').to_a.delete_if{ |snippet| snippet.time_remaining >= 0  }
    snippets.last
  end

  def self.next
    snippets = Snippet.order('showTime ASC').to_a.delete_if{ |snippet| snippet.time_remaining < 0  }
    snippets.first
  end

end
