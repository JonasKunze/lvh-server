class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.datetime :lastActivityTime
          
      t.timestamps null: false
    end
  end
end
