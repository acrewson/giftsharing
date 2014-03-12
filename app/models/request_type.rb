class RequestType < ActiveRecord::Base
  # Associations
    has_many :items

  # Validations
    validates :request_type_description, presence: true


end
