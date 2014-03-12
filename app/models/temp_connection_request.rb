class TempConnectionRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :connection_type
end
