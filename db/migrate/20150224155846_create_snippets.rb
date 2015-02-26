class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :french
      t.text :german
      t.integer :showTime

      t.timestamps null: false
    end
  end
end
