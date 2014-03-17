class WelcomeController < ApplicationController


  #####################################################################

  # This will figure out the number of connections if someone is logged in

  before_action :check_login

  def check_login
    @current_user = User.find_by(:id => session[:user_id])

    if @current_user.nil?
      @current_user = User.find_by(:id => cookies.signed[:remember_me])
      session[:user_id] = cookies.signed[:remember_me]
    end

    if @current_user.present?
      @num_pending_req = ConnectionRequest.where("requested_user_id = ?", @current_user.id).count
    end

    true
  end

  #####################################################################




def home

  @current_user = User.find_by(:id => session[:user_id])

  if @current_user.present?
    @my_recent_lists = @current_user.lists.where("datedeleted is ?", nil).order("updated_at desc").limit(2)

    @my_recent_shared_lists = List.joins(:shared_lists).where("shared_lists.user_id = ? and lists.datedeleted is ?", @current_user.id, nil).order("updated_at desc").limit(2)

  end

  if params[:verify].present?
    @sec_verif = params[:verify]
  end

  render 'home_page'
end


def create_account

  current_user = User.find_by(:id => session[:user_id])

  if current_user.present?
    redirect_to "/mylists"
  else
    render 'create_account'
  end

end


end
