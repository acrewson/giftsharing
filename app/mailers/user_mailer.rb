class UserMailer < ActionMailer::Base
  default from: "giftsharingtest@gmail.com"

 def connection_request_email(current_user, requested_user)
    @current_user = current_user
    @requested_user = requested_user
    @url  = 'http://localhost:3000/connections'
    mail(to: @requested_user.email, subject: "#{@current_user.firstname} would like to connect on Gift Share!")
  end

 def connection_invite_email(current_user, requested_email)
    @current_user = current_user
    @requested_email = requested_email
    @url  = 'http://localhost:3000/login'
    mail(to: @requested_email, subject: "#{@current_user.firstname} would like to connect on Gift Share!")
  end



end
