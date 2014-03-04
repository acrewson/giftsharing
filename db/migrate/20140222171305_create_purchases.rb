class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :item_id
      t.integer :user_id
      t.datetime :date_purchased
      t.integer :quantity_purchased

      t.timestamps
    end
  end
end


