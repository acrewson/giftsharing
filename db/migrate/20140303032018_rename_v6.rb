class RenameV6 < ActiveRecord::Migration
  def change
    rename_column :request_types, :request_type_descriptions, :request_type_description
  end
end
