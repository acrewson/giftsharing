class Renamecol < ActiveRecord::Migration
  def change
    rename_column :lists, :listType_id, :deprecated2
  end
end
