class Rating < ActiveRecord::Base
  belongs_to :rating_mark
  belongs_to :user
end
