class Gender < ActiveRecord::Base
  # Associations
    has_many :users

  # Validations
    validates :gender_name, presence: true

end
