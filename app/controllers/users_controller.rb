require 'securerandom'

class UsersController < ApplicationController

  #####################################################################

  # This will require that a user is logged in before executing any method in this controller

  before_action :require_login, :except => [:create_new_user]

  # The rails guides have "private" here - but this breaks things. Why?

  def require_login
    @current_user = User.find_by(:id => session[:user_id])

    if @current_user.nil?
      @current_user = User.find_by(:id => cookies.signed[:remember_me])
      session[:user_id] = cookies.signed[:remember_me]
    end

    @num_pending_req = ConnectionRequest.where("requested_user_id = ?", @current_user.id).count

    unless @current_user.present?
      redirect_to "/", notice: "Please login to see this page"
    end
    true
  end

  #####################################################################




  def create_new_user

    if User.find_by(:email => params[:email]).present?
      redirect_to "/create_account", notice: "Sorry, that email is already taken"
    else

      if TempUser.find_by(:email => params[:email]).present?
        z = TempUser.find_by(:email => params[:email])
      else
        z = TempUser.new
      end

      z.firstname = params[:firstname]
      z.lastname = params[:lastname]
      z.email = params[:email]
      z.password = params[:pwd]
      z.security_code = SecureRandom.urlsafe_base64

      if z.valid? == true
        z.save

        UserMailer.account_create_verify_email(z).deliver

        redirect_to "/", notice: "Please check your email and follow the link to complete your registration."

      else
        redirect_to "/create_account", notice: "Please enter valid inputs"
      end

    end

  end


  def profile_view
    @current_user = User.find_by(:id => session[:user_id])

  end

  def profile_edit
    @current_user = User.find_by(:id => session[:user_id])

  end


  def profile_update
    @current_user = User.find_by(:id => session[:user_id])

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
