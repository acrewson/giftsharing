class CreateRelationtypes < ActiveRecord::Migration
  def change
    create_table :relationtypes do |t|
      t.string :relation_type_desc

      t.timestamps
    end
  end
end
