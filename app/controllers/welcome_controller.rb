class WelcomeController < ApplicationController

def home
  cookies.signed[:remember_me] = 5

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
