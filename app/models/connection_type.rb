class ConnectionType < ActiveRecord::Base
  has_many :connections
  has_many :connection_requests
end
