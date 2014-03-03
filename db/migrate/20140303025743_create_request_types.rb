class CreateRequestTypes < ActiveRecord::Migration
  def change
    rename_column :items, :request_type, :deprecated2

    create_table :request_types do |t|
      t.string :request_type_descriptions
      t.timestamps
    end
  end
end
