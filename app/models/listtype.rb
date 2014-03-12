class Listtype < ActiveRecord::Base
  # Associations
    has_many :lists

  # Validations
    validates :listtype, presence: true

end
