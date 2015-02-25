class RatingMark < ActiveRecord::Base
  has_many :ratings
  has_and_belongs_to_many :snippets
end
