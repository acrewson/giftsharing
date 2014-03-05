class User < ActiveRecord::Base
  has_many :lists
  has_many :purchases
  has_many :shared_lists
  has_many :connections
  has_many :connection_requests
end
