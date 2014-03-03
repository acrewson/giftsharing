class Item < ActiveRecord::Base
  belongs_to :list
  has_many :purchases
  has_one :requesttype
end
