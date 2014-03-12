class SharedList < ActiveRecord::Base
  # Associations
    belongs_to :user
    belongs_to :list

  # Validations
    validates :list_id, presence: true
    validates :user_id, presence: true


end
