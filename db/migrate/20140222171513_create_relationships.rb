class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :shared_user_id
      t.integer :relation_type_id

      t.timestamps
    end
  end
end
