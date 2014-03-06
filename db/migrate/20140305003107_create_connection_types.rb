class CreateConnectionTypes < ActiveRecord::Migration
  def change
    create_table :connection_types do |t|
      t.string :connection_description
      t.integer :inverse_male_connection_id
      t.integer :inverse_female_connection_id
      t.integer :inverse_unknown_connection_id
      t.timestamps
    end
  end
end
