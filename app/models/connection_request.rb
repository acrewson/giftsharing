class ConnectionRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :connection_type
end
