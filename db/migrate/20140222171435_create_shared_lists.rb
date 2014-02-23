class CreateSharedLists < ActiveRecord::Migration
  def change
    create_table :shared_lists do |t|
      t.integer :list_id
      t.integer :shared_user_id
      t.datetime :shared_date

      t.timestamps
    end
  end
end
