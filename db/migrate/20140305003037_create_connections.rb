class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :connected_user_id
      t.integer :connection_type_id

      t.timestamps


      t.timestamps
    end
  end
end
