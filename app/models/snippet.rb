class Snippet < ActiveRecord::Base
  has_and_belongs_to_many :rating_marks
  has_many :ratings
end
