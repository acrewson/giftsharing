class UserMailer < ActionMailer::Base
  default from: "savvygifter@gmail.com"



 def account_create_verify_email(temp_user)
    @temp_user = temp_user
    # @url = "http://localhost:3000/?verify=#{@temp_user.security_code}"
    # @url  = "http://afternoon-inlet-6717.herokuapp.com/?verify=#{@temp_user.security_code}"
    @url  = "http://www.savvygifter.com/?verify=#{@temp_user.security_code}"
    mail(to: @temp_user.email, subject: "Welcome to Savvy Gifter, #{@temp_user.firstname}!")
  end



 def connection_request_email(current_user, requested_user)
    @current_user = current_user
    @requested_user = requested_user
    # @url  = 'http://localhost:3000/'
    # @url  = 'http://afternoon-inlet-6717.herokuapp.com'
    @url  = 'http://www.savvygifter.com'
    mail(to: @requested_user.email, subject: "#{@current_user.firstname} would like to connect on Savvy Gifter!")
  end

 def connection_invite_email(current_user, requested_email, temp_pw, sec_code)
    @current_user = current_user
    @requested_email = requested_email
    # @url  = 'http://afternoon-inlet-6717.herokuapp.com'
    @url  = "http://www.savvygifter.com/?verify=#{sec_code}"
    @temp_pw = temp_pw
    mail(to: @requested_email, subject: "#{@current_user.firstname} would like to connect on Savvy Gifter!")
  end



end
