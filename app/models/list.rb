class List < ActiveRecord::Base
  belongs_to :user
  belongs_to :listtype
  has_many :items
  has_many :shared_lists

end
