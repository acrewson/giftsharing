class SessionsController < Devise::SessionsController

  def create
    convert_temp()

    # This is the normal devise sesssions/create code

    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)

  end # End the create action





  def convert_temp
    if params[:sec_verif].present?
      tu = TempUser.find_by(:email => params[:user][:email])

      if tu.nil?
        true # just want it to skip and move on with normal log in in this case

      elsif tu.present? && params[:sec_verif] == tu.security_code && tu.valid_password?(params[:user][:password])

        # Create the user account
        new_user = User.new
        new_user.firstname = tu.firstname
        new_user.lastname = tu.lastname
        new_user.email = tu.email
        new_user.password = params[:user][:password]
        new_user.password_confirmation = params[:user][:password]
        new_user.sign_in_count = 0
        new_user.save


        # Transfer any temporary connection requests to be real ones
        TempConnectionRequest.where("requested_temp_user_id = ?", tu.id).each do |convert|
          cr = ConnectionRequest.new
          cr.user_id = convert.user_id
          cr.requested_user_id = new_user.id
          cr.connection_type_id = convert.connection_type_id
          cr.request_date = convert.request_date
          cr.save
        end # ends teh temp connection loop


        # Delete the temporary requests
        TempConnectionRequest.where("requested_temp_user_id = ?", tu.id).destroy_all

        # Delete the temporary user
        tu.destroy
      else
        redirect_to "/", notice: "Something went wrong, please try again."
      end  # ends the actions of logging in IF correct security code

    end # ends set of actions if there is a security code present


  end  # ends the convert temp action

end  # Ends the controller
