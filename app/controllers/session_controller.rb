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
      redirect_to "/mylists"
    else
      redirect_to "/", notice: "Wrong password - give it another try"
    end
  else
    redirect_to "/", notice: "No account exists for that email address"
  end
end





def destroy
  @current_user = User.find_by(:id => session[:user_id])

  if @current_user.present?
    reset_session
    redirect_to root_url, notice: "You have logged out successfully"
  else
    redirect_to root_url
  end


end



end
