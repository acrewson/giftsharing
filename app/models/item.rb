class Item < ActiveRecord::Base
  # Associations
    belongs_to :list
    has_many :purchases
    belongs_to :request_type

  # Validations
    validates :description, presence: true
    validates :quantity_requested, presence: true, numericality: true
    validates :list_id, presence: true
    validates :request_type_id, presence: true



end
