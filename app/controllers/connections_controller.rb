require 'time'
require 'securerandom'

class ConnectionsController < ApplicationController

  #####################################################################

  # This will require that a user is logged in before executing any method in this controller

  before_action :authenticate_user!

  # The rails guides have "private" here - but this breaks things. Why?

  before_action :num_requests

  def num_requests
    @num_pending_req = ConnectionRequest.where("requested_user_id = ?", current_user.id).count
  end

  #####################################################################



  def home

      @current_user = current_user

      # Find people I am connected to
      @my_connections = User.select("users.*, connections.connection_type_id").joins("
          JOIN connections
            ON connections.connected_user_id = users.id
            AND connections.user_id = #{@current_user.id}"
      )

      @my_pending_connections = User.joins(:connection_requests).where("requested_user_id = ?", @current_user.id)

  end

  def connection_edit
      @current_user = current_user

      @my_connections = User.select("users.*, connections.connection_type_id").joins("
          JOIN connections
            ON connections.connected_user_id = users.id
            AND connections.user_id = #{@current_user.id}"
      )
  end

  def connection_update
    @current_user = current_user

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
    @current_user = current_user
    # Add some security checks

    # Delete the primary relationship
    Connection.find_by(:user_id => @current_user.id, :connected_user_id => params[:connection_id]).destroy

    # Delete the mirrored relationship
    Connection.find_by(:user_id => params[:connection_id], :connected_user_id => @current_user.id).destroy

    redirect_to "/connections/edit"

  end



  def request_response
    # Note - add a bunch of validation here later

    @current_user = current_user
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
    @current_user = current_user
    requested_user = User.find_by(:email => params[:request_email])

    if requested_user.nil?
      requested_user_id = -99
    else
      requested_user_id = requested_user.id
    end


    ########## Sanity checks ##############

    # Is not yourself
    is_self = 0
    if @current_user.id == requested_user_id
      is_self = 1
    end

    # Is not already a connection
    is_already_connection = 0
    if @current_user.connections.find_by(:connected_user_id => requested_user_id).present?
      is_already_connection = 1
    end

    # There isn't already a pending request out to this person from you (and they are a member)
    is_already_pending_request_from_you = 0
    if @current_user.connection_requests.find_by(:requested_user_id => requested_user_id)
      is_already_pending_request_from_you = 1
    end

    # There isn't already a pending request out to this person from you (and they are NOT a member)
    is_already_pending_request_from_you_temp = 0
    if @current_user.temp_connection_requests.find_by(:requested_temp_user_id => requested_user_id)
      is_already_pending_request_from_you_temp = 1
    end

    # You don't have a pending request already from them
    is_already_pending_request_to_you = 0
    if ConnectionRequest.find_by(:user_id => requested_user_id, :requested_user_id => @current_user.id).present?
      is_already_pending_request_to_you = 1
    end

    ################################

    if requested_user.present? and is_self == 0 and is_already_connection == 0 and is_already_pending_request_from_you ==0 and is_already_pending_request_to_you ==0 and is_already_pending_request_from_you_temp == 0

      cr = ConnectionRequest.new
      cr.user_id = @current_user.id
      cr.requested_user_id = User.find_by(:email => params[:request_email]).id
      cr.connection_type_id = params[:connection_type]
      cr.request_date  = Time.now
      cr.save

      UserMailer.connection_request_email(@current_user, requested_user).deliver

      redirect_to "/connections", notice: "A connection request has been sent to #{params[:request_email]}"

    elsif requested_user.present? and is_self == 0 and is_already_connection == 0 and is_already_pending_request_from_you ==1 and is_already_pending_request_to_you ==0 and is_already_pending_request_from_you_temp == 0

      redirect_to "/connections", notice: "There is already a request pending for #{requested_user.firstname + " " + requested_user.lastname + " (" + requested_user.email + ")"}."


    elsif requested_user.present? and is_self == 0 and is_already_connection == 0 and is_already_pending_request_from_you ==0 and is_already_pending_request_to_you ==1 and is_already_pending_request_from_you_temp == 0


      redirect_to "/connections", notice: "#{requested_user.firstname + " " + requested_user.lastname + " (" + requested_user.email + ") has already invited you to connect. Respond below!"}"


    elsif requested_user.present? and is_self == 0 and is_already_connection == 1

      redirect_to "/connections", notice: "You are already connected to #{requested_user.firstname + " " + requested_user.lastname + " (" + requested_user.email + ")."}"

    elsif is_self == 1

      redirect_to "/connections", notice: "Please enter someone else's email address"

    elsif requested_user.nil?

      # Create a temp user for this person
      if TempUser.find_by(:email => params[:request_email]).present?
        z = TempUser.find_by(:email => params[:request_email])
      else
        z = TempUser.new
        z.email = params[:request_email]
        # This next one is just a placeholder for now, user not sent this for now
        z.security_code = SecureRandom.urlsafe_base64

        # Placeholders
        z.firstname = "Placeholder"
        z.lastname = "Placeholder"
        z.password = "#{SecureRandom.urlsafe_base64[0,15]}"

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

        # Send the invite email
        UserMailer.connection_invite_email(@current_user, params[:request_email]).deliver

        redirect_to "/connections", notice: "There is no account registered to #{params[:request_email]}. We've sent them an invitation to join."

      else
        redirect_to "/connections", notice: "You have already invited #{params[:request_email]} to join previously"
      end

    end

  end






end
