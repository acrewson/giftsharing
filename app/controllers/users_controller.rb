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


  def profile_view
    @current_user = current_user.id

  end

  def profile_edit
    @current_user = current_user.id

  end


  def profile_update
    @current_user = current_user.id

    # Update the user's info based on their inputs
    u = User.find_by(:id => @current_user.id)
    u.firstname = params[:firstname]
    u.lastname = params[:lastname]

    # Process and validate the date
    date_split = params[:birthdate].split("/")
    bd_error = []

    if date_split.length != 3
      bd_error.push("Please enter a date in the format MM/DD/YYYY")
    else

      if date_split.first.to_i < 1 or date_split.first.to_i > 12
        bd_error.push("Please enter a month between 1 and 12")
      end

      if date_split[1].to_i < 1 or date_split.first.to_i > 31
        bd_error.push("Please enter a valid day of the month")
      end

      if date_split.last.length != 4
        bd_error.push("Please enter a 4 digit year")
      end
    end

    if bd_error.length == 0
      u.birthdate = Date.strptime(params[:birthdate], "%m/%d/%Y")
    end


    u.address = params[:address]
    u.city = params[:city]
    u.state_id = params[:state]
    u.zip = params[:zip]
    u.gender_id = params[:gender]
    u.save

    if bd_error.length == 0
      redirect_to "/myprofile", notice: "Your profile has been updated."
    else
      redirect_to "/myprofile", notice: "Check your birthday - there may have been an issue"
    end



  end



end
