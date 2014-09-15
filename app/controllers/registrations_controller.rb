require 'securerandom'

class RegistrationsController < Devise::RegistrationsController

  def create

    build_resource(sign_up_params)

    # The following were my lines to add a security code for the email
    resource.security_code = SecureRandom.urlsafe_base64
    resource.save


    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)

        @temp_user = resource
        UserMailer.account_create_verify_email(resource).deliver
        # redirect_to "/", notice: "Please check your email and follow the link to complete your registration."
        redirect_to "/confirm_account"

        # respond_with resource, location: root_url # after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end

  end


  private

  def sign_up_params
    params.require(:temp_user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:temp_user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password)
  end

  protected

  def sign_up(resource_name, resource)
    true
  end





end
