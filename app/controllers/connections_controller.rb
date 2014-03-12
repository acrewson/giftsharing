require 'time'
require 'securerandom'

class ConnectionsController < ApplicationController

  #####################################################################

  # This will require that a user is logged in before executing any method in this controller

  before_action :require_login

  # The rails guides have "private" here - but this breaks things. Why?

  def require_login
    @current_user = User.find_by(:id => session[:user_id])

    if @current_user.nil?
      @current_user = User.find_by(:id => cookies.signed[:remember_me])
      session[:user_id] = cookies.signed[:remember_me]
    end

    unless @current_user.present?
      redirect_to "/", notice: "Please login to see this page"
    end
    true
  end

  #####################################################################



  def home

      @current_user = User.find_by(:id => session[:user_id])

      # Find people I am connected to
      @my_connections = User.select("users.*, connections.connection_type_id").joins("
          JOIN connections
            ON connections.connected_user_id = users.id
            AND connections.user_id = #{@current_user.id}"
      )

      @my_pending_connections = User.joins(:connection_requests).where("requested_user_id = ?", @current_user.id)

  end

  def connection_edit
      @current_user = User.find_by(:id => session[:user_id])

      @my_connections = User.select("users.*, connections.connection_type_id").joins("
          JOIN connections
            ON connections.connected_user_id = users.id
            AND connections.user_id = #{@current_user.id}"
      )
  end

  def connection_update
    @current_user = User.find_by(:id => session[:user_id])

    # Parse the connection id out of the value
    {:connection_2_type=>"2", :connection_3_type=>"3", :connection_7_type=>"8", :connection_117_type=> "9"}

    params.keys.each do |p|
      if p[0,"connection_".length] == "connection_"
        connec_id = p["connection_".length, p.length - "connection__type".length].to_i

        c = Connection.find_by(:user_id => @current_user.id, :connected_user_id => connec_id)
        c.connection_type_id = params["#{p}"].to_i
        c.save
      end

    end

    redirect_to "/connections/edit"
  end

  def connection_delete
    @current_user = User.find_by(:id => session[:user_id])
    # Add some security checks

    # Delete the primary relationship
    Connection.find_by(:user_id => @current_user.id, :connected_user_id => params[:connection_id]).destroy

    # Delete the mirrored relationship
    Connection.find_by(:user_id => params[:connection_id], :connected_user_id => @current_user.id).destroy

    redirect_to "/connections/edit"

  end



  def request_response
    # Note - add a bunch of validation here later

    @current_user = User.find_by(:id => session[:user_id])
    cr = params["connec_response"]

    # Find the connected user based on which button was clicked
    if cr[0,"Accept".length] == "Accept"
      decision = "Accept"
      decision_id = cr[6,cr.length - 6].to_i
    elsif cr[0,"Decline".length] == "Decline"
      decision = "Decline"
      decision_id = cr[7,cr.length - 7].to_i
    end

    @connected_user = User.find_by(:id => decision_id)
    connected_type = params["connection_#{decision_id.to_s}_type"]


    if decision == "Accept"

      # Add both relations to the Connection model

        # Add the relationship for the current user
        c = Connection.new
        c.user_id = @current_user.id
        c.connected_user_id = @connected_user.id
        c.connection_type_id = connected_type.to_i
        c.save

        # Add the relationship for the other connection
        c = Connection.new
        c.user_id = @connected_user.id
        c.connected_user_id = @current_user.id
        c.connection_type_id = ConnectionRequest.find_by(:user_id => @connected_user.id, :requested_user_id => @current_user.id).connection_type_id
        c.save

      # Delete from the ConnectionRequest model
        ConnectionRequest.find_by(:user_id => @connected_user.id, :requested_user_id => @current_user.id).destroy

      redirect_to "/connections", notice: "Connection Added!"
    elsif decision == "Decline"

      # Delete the request from the ConnectionRequest model
      ConnectionRequest.find_by(:user_id => @connected_user.id, :requested_user_id => @current_user.id).destroy

      redirect_to "/connections", notice: "Connection Declined"
    else
      redirect_to "/connections", notice: "Something went wrong with your request."
    end
  end







  def send_request
    @current_user = User.find_by(:id => session[:user_id])

    # Make sure the user isn't already connected to this person

    # Make sure this user exists, if not, add to pending table, generate email inviting them.

    # Make sure there isn't a request pending to this email already

    # Given this email is registered, add a row to the requests table

    requested_user = User.find_by(:email => params[:request_email])

    if requested_user.present? && @current_user.connections.find_by(:connected_user_id => requested_user.id).nil? && ConnectionRequest.find_by(:user_id => requested_user.id, :requested_user_id => session[:user_id]).nil? && @current_user.connection_requests.find_by(:requested_user_id => requested_user.id).nil?

      cr = ConnectionRequest.new
      cr.user_id = @current_user.id
      cr.requested_user_id = User.find_by(:email => params[:request_email]).id
      cr.connection_type_id = params[:connection_type]
      cr.request_date  = Time.now
      cr.save

      UserMailer.connection_request_email(@current_user, requested_user).deliver

      redirect_to "/connections", notice: "A connection request has been sent to #{params[:request_email]}"

    elsif requested_user.present? && @current_user.connections.find_by(:connected_user_id => requested_user.id).nil? && ConnectionRequest.find_by(:user_id => requested_user.id, :requested_user_id => session[:user_id]).nil? && @current_user.connection_requests.find_by(:requested_user_id => requested_user.id).present?

      redirect_to "/connections", notice: "There is already a request pending for #{requested_user.firstname + " " + requested_user.lastname + " (" + requested_user.email + ")"}."


    elsif requested_user.present? && @current_user.connections.find_by(:connected_user_id => requested_user.id).nil? && ConnectionRequest.find_by(:user_id => requested_user.id, :requested_user_id => session[:user_id]).present?


    redirect_to "/connections", notice: "#{requested_user.firstname + " " + requested_user.lastname + " (" + requested_user.email + ") has already invited you to connect. Respond below!"}"


    elsif requested_user.present? && @current_user.connections.find_by(:connected_user_id => requested_user.id).present?

      redirect_to "/connections", notice: "You are already connected to #{requested_user.firstname + " " + requested_user.lastname + " (" + requested_user.email + ")."}"

    elsif requested_user.nil?

      # Create a temp user for this person
      if TempUser.find_by(:email => params[:request_email]).present?
        z = TempUser.find_by(:email => params[:request_email])
      else
        z = TempUser.new
        z.email = params[:request_email]
        # This next one is just a placeholder, user not sent this for now
        z.security_code = SecureRandom.urlsafe_base64
        z.save
      end

      # Add this relationship to the temp_user_requests table
      if TempConnectionRequest.find_by(:user_id => @current_user.id, :requested_temp_user_id => z.id).nil?

        trc = TempConnectionRequest.new
        trc.user_id = @current_user.id
        trc.requested_temp_user_id = z.id
        trc.connection_type_id = params[:connection_type]
        trc.request_date = Time.now
        trc.save

      end

      # Send the invite email
      UserMailer.connection_invite_email(@current_user, params[:request_email]).deliver

      redirect_to "/connections", notice: "There is no account registered to #{params[:request_email]}. We've sent them an invitation to join."
    end

  end






end
