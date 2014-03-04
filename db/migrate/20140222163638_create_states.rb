class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :state_abbrev

      t.timestamps
    end
  end
end
