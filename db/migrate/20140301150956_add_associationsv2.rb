class AddAssociationsv2 < ActiveRecord::Migration
  def change
    change_table :lists do |t|
      t.belongs_to :user
    end
  end
end
