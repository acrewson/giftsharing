class UpdateRequestTypeinItems < ActiveRecord::Migration
  def change

    change_table :items do |t|
      t.belongs_to :requesttype
    end

  end
end
