class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.datetime :startTime

      t.timestamps null: false
    end
  end
end
