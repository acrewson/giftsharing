class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :listname
      t.integer :listtype_id
      t.date :eventdate
      t.integer :user_id
      t.datetime :datedeleted

      t.timestamps
    end
  end
end
