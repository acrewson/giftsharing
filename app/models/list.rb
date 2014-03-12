class List < ActiveRecord::Base
  # Associations
    belongs_to :user
    belongs_to :listtype
    has_many :items
    has_many :shared_lists
    has_many :users, through: :shared_lists

  # Validations
    validates :listname, presence: true
    validates :listtype_id, presence: true
    validates :eventdate, presence: true
    validates :user_id, presence: true

end
