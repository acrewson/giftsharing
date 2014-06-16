class PurchasesController < ApplicationController

  #####################################################################

  # This will require that a user is logged in before executing any method in this controller

  before_action :authenticate_user!

  # The rails guides have "private" here - but this breaks things. Why?

  before_action :num_requests

  def num_requests
    @num_pending_req = ConnectionRequest.where("requested_user_id = ?", current_user.id).count
  end

  #####################################################################





    def view_my_purchases
        @current_user = User.find_by(:id => session[:user_id])
    end

end
