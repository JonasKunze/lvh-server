class AddExplanationToRatingMarks < ActiveRecord::Migration
  def change
    add_column :rating_marks, :explanation, :text
  end
end
