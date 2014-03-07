class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.integer :quantity_requested
      t.text :comments
      t.string :url
      t.datetime :date_deleted
      t.text :reason_deleted
      t.integer :list_id
      t.integer  :request_type_id

      t.timestamps
    end
  end
end

