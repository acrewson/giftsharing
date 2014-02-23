class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :listname
      t.integer :listType_id
      t.date :eventdate
      t.integer :user_id
      t.datetime :datedeleted

      t.timestamps
    end
  end
end
