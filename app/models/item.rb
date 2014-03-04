class Item < ActiveRecord::Base
  belongs_to :list
  has_many :purchases
  belongs_to :request_type
end
