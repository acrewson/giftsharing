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


end
