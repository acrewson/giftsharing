class Purchase < ActiveRecord::Base
  # Associations
    belongs_to :item
    belongs_to :user

  # Validations
    validates :item_id, presence: true
    validates :user_id, presence: true
    validates :date_purchased, presence: true
    validates :quantity_purchased, presence: true, numericality: true


end
