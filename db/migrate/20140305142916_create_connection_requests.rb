class CreateConnectionRequests < ActiveRecord::Migration
  def change
    create_table :connection_requests do |t|
      t.integer :user_id
      t.integer :requested_user_id
      t.integer :connection_type_id
      t.datetime :request_date
      t.timestamps
    end
  end
end
