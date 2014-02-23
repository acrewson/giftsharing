class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthdate
      t.string :address
      t.string :city
      t.integer :state_id
      t.integer :zip
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
