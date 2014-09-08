class PurchasesController < ApplicationController

  #####################################################################

  # This will require that a user is logged in before executing any method in this controller

  before_action :authenticate_user!

  before_action :num_requests

  before_action :complete_profile

  def num_requests
    @num_pending_req = ConnectionRequest.where("requested_user_id = ?", current_user.id).count
  end

  def complete_profile
    if current_user.gender.nil? || current_user.birthdate.nil?
      redirect_to "/myprofile", notice: "You need to complete your profile first!"
    end

  end

  #####################################################################


    def view_my_purchases
        @current_user = current_user
    end

end
