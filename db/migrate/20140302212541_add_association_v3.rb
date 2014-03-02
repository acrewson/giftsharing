class AddAssociationV3 < ActiveRecord::Migration
  def change
    change_table :lists do |t|
      t.belongs_to :listtype
    end
  end
end
