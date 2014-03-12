class PurchasesController < ApplicationController

  #####################################################################

  # This will require that a user is logged in before executing any method in this controller

  before_action :require_login

  # The rails guides have "private" here - but this breaks things. Why?

  def require_login
    @current_user = User.find_by(:id => session[:user_id])
    unless @current_user.present?
      redirect_to "/", notice: "Please login to see this page"
    end
    true
  end

  #####################################################################





    def view_my_purchases
        @current_user = User.find_by(:id => session[:user_id])
    end

end
