class CreateRatingMarks < ActiveRecord::Migration
  def change
    create_table :rating_marks do |t|
      t.string :title, null: false
      
      t.timestamps null: false
    end
  end
end
