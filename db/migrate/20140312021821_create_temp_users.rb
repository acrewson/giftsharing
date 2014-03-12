class CreateTempUsers < ActiveRecord::Migration
  def change
    create_table :temp_users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password
      t.string :security_code
      t.timestamps
    end
  end
end
