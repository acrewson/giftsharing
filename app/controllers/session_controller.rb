class SessionController < ApplicationController

def login
end

def authenticate
  user = User.find_by(:email => params[:email])

  if user.present?
    if user.password == params[:pwd]
      session[:user_id] = user.id
      redirect_to "/mylists"
    else
      redirect_to "/login", notice: "Wrong password - give it another try"
    end
  else
    redirect_to "/login", notice: "No account exists for that email address"
  end
end

def destroy
  reset_session
  redirect_to root_url, notice: "You have logged out successfully"
end



end
