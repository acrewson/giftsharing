class AddAssocV5 < ActiveRecord::Migration
  def change

    change_table :shared_lists do |t|
      t.belongs_to :list
      t.belongs_to :user
    end


  end
end
