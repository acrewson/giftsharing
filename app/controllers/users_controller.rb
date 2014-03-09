class UsersController < ApplicationController

  def create_new_user

    if User.find_by(:email => params[:email]).present?
      redirect_to "/login", notice: "Sorry, that email is already taken"
    elsif 0 == 1
    else
      z = User.new
      z.firstname = params[:firstname]
      z.lastname = params[:lastname]
      z.email = params[:email]
      z.password = params[:pwd]
      z.save

      redirect_to "/login", notice: "Your account has been created - please login."
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
    u.birthdate = params[:birthdate]
    u.address = params[:address]
    u.city = params[:city]
    u.state_id = params[:state]
    u.zip = params[:zip]
    u.gender_id = params[:gender]
    u.save


    redirect_to "/myprofile", notice: "Your profile has been updated."

  end



end
