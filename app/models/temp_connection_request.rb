class TempConnectionRequest < ActiveRecord::Base
  # Associations
    belongs_to :user
    belongs_to :connection_type

  # Validations
    validates :user_id, presence: true
    validates :requested_temp_user_id, presence: true
    validates :connection_type_id, presence: true
    validates :request_date, presence: true

end
