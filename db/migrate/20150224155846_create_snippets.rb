class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :french
      t.text :german
      t.integer :showTimeOffset

      t.timestamps null: false
    end
  end
end
