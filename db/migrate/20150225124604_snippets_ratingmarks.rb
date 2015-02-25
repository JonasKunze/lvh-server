class SnippetsRatingmarks < ActiveRecord::Migration
  def change
     create_table :rating_marks_snippets, id: false do |t|
      t.belongs_to :snippet, index: true
      t.belongs_to :rating_mark, index: true
     end
  end
end
