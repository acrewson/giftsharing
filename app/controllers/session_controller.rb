class SessionController < ApplicationController



def authenticate
  @current_user = User.find_by(:id => session[:user_id])
  user = User.find_by(:email => params[:email])

  if @current_user.present?
    redirect_to "/logout", notice: "Something went wrong - please try again."

  elsif user.present?
    if user.password == params[:pwd]
      # This next line is where I name the session key that I'll use throughout
      session[:user_id] = user.id

      if params[:remember_login] == "true"
        cookies.signed[:remember_me] = {value: user.id, expires: 1.hour.from_now}

      end


      redirect_to "/mylists"
    else
      redirect_to "/", notice: "Wrong password - give it another try"
    end
  elsif user.nil? and params[:sec_verif].present?
    tu = TempUser.find_by(:email => params[:email])

    if params[:sec_verif] == tu.security_code

      # Create the user account
      new_user = User.new
      new_user.firstname = tu.firstname
      new_user.lastname = tu.lastname
      new_user.email = tu.email
      new_user.password = tu.password
      new_user.save

      # Transfer any temporary connection requests to be real ones
      TempConnectionRequest.where("requested_temp_user_id = ?", tu.id).each do |convert|
        cr = ConnectionRequest.new
        cr.user_id = convert.user_id
        cr.requested_user_id = new_user.id
        cr.connection_type_id = convert.connection_type_id
        cr.request_date = convert.request_date
        cr.save
      end

      # Delete the temporary requests
      TempConnectionRequest.where("requested_temp_user_id = ?", tu.id).destroy_all

      # Log the person in
      user = User.find_by(:email => params[:email])
      session[:user_id] = user.id
      redirect_to "/myprofile/edit", notice: "Complete your profile below and then get started!"

      # Remove this temp user
      tu.destroy

    else
      redirect_to "/", notice: "Something went wrong, please try again."

    end

  else
    redirect_to "/", notice: "No account exists for that email address"
  end
end





def destroy
  @current_user = User.find_by(:id => session[:user_id])

  # if cookies.signed[:remember_me].present?
    cookies.delete(:remember_me)
  # end


  if @current_user.present?
    reset_session
    redirect_to root_url, notice: "You have logged out successfully"
  else
    redirect_to root_url
  end


end



end
