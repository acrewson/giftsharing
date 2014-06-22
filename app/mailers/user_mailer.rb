class UserMailer < ActionMailer::Base
  default from: "giftsharingtest@gmail.com"



 def account_create_verify_email(temp_user)
    @temp_user = temp_user
    @url = "http://localhost:3000/?verify=#{@temp_user.security_code}"
    # @url  = "http://afternoon-inlet-6717.herokuapp.com/?verify=#{@temp_user.security_code}"
    mail(to: @temp_user.email, subject: "Welcome to Gift Sharing, #{@temp_user.firstname}!")
  end



 def connection_request_email(current_user, requested_user)
    @current_user = current_user
    @requested_user = requested_user
    @url  = 'http://localhost:3000/'
    # @url  = 'http://afternoon-inlet-6717.herokuapp.com'
    mail(to: @requested_user.email, subject: "#{@current_user.firstname} would like to connect on Gift Share!")
  end

 def connection_invite_email(current_user, requested_email)
    @current_user = current_user
    @requested_email = requested_email
    @url  = 'http://afternoon-inlet-6717.herokuapp.com'
    mail(to: @requested_email, subject: "#{@current_user.firstname} would like to connect on Gift Share!")
  end



end
