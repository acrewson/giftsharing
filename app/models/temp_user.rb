class TempUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :email, presence: true
    validates :password, presence: true, length: { in: 6..20 }




end
