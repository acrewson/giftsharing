class AddrequesttypetoItems < ActiveRecord::Migration
  def change
    drop_column :items, :request_type, :integer
  end
end
