class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, null: false
      t.references :rating_mark, index: true, null: false
      t.references :snippet, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :ratings, :rating_marks
  end
end
