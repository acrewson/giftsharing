class RenameAgain < ActiveRecord::Migration
  def change
    rename_column :shared_lists, :shared_user_id, :deprecated2
  end
end
