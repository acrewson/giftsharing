class TempUser < ActiveRecord::Base

  # Validations
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :email, presence: true
    validates :password, presence: true, length: { in: 6..20 }




end
