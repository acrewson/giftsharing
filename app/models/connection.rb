class Connection < ActiveRecord::Base
  belongs_to :connection_type
  belongs_to :user
end
