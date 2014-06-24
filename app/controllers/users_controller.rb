require 'securerandom'

class UsersController < Devise::RegistrationsController

  #####################################################################

  # This will require that a user is logged in before executing any method in this controller

  before_action :authenticate_user!

  #####################################################################

  def home

    @current_user = current_user

    if @current_user.present?
      @my_recent_lists = @current_user.lists.where("datedeleted is ?", nil).order("updated_at desc").limit(2)

      @my_recent_shared_lists = List.joins(:shared_lists).where("shared_lists.user_id = ? and lists.datedeleted is ?", @current_user.id, nil).order("updated_at desc").limit(2)

    end

    if params[:verify].present?
      @sec_verif = params[:verify]
    end

    render 'home_page'
  end




end
