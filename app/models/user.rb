class User < ActiveRecord::Base
  # Associations
    has_many :lists
    has_many :purchases
    has_many :shared_lists
    has_many :connections
    has_many :connection_requests
    has_many :temp_connection_requests
    belongs_to :gender
    belongs_to :state

  # Validations
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { in: 6..20 }

end
