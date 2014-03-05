class ConnectionsController < ApplicationController

def home
  @current_user = User.find_by(:id => session[:user_id])

  # Find people I am connected to
  @my_connections = User.select("users.*, connections.connection_type_id").joins("JOIN connections ON connections.connected_user_id = users.id AND connections.user_id = #{@current_user.id}")

  @my_pending_connections = User.joins(:connection_requests).where("requested_user_id = ?", @current_user.id)

end

end
