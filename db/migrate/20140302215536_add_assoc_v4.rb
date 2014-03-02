class AddAssocV4 < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.belongs_to :list
    end

    change_table :purchases do |t|
      t.belongs_to :item
      t.belongs_to :user
    end

  end
end
