class Connection < ActiveRecord::Base
  # Associations
    belongs_to :connection_type
    belongs_to :user

  # Validations
    validates :user_id, presence: true
    validates :connected_user_id, presence: true
    validates :connection_type_id, presence: true

end
