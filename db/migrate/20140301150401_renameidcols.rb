class Renameidcols < ActiveRecord::Migration
  def change
    rename_column :lists, :user_id, :deprecated
    rename_column :items, :list_id, :deprecated
    rename_column :purchases, :item_id, :deprecated
    rename_column :purchases, :purchase_user_id, :deprecated2
    rename_column :relationships, :user_id, :deprecated
    rename_column :shared_lists, :list_id, :deprecated
  end
end
