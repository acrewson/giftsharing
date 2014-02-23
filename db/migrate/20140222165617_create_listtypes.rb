class CreateListtypes < ActiveRecord::Migration
  def change
    create_table :listtypes do |t|
      t.string :listtype

      t.timestamps
    end
  end
end
