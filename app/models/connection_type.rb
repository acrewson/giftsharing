class ConnectionType < ActiveRecord::Base
  # Associations
    has_many :connections
    has_many :connection_requests

  # Validations
    validates :connection_description, presence: true
    validates :inverse_male_connection_id, presence: true
    validates :inverse_female_connection_id, presence: true
    validates :inverse_unknown_connection_id, presence: true

end
