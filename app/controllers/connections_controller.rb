require 'time'

class ConnectionsController < ApplicationController

  def home
    @current_user = User.find_by(:id => session[:user_id])

    # Find people I am connected to
    @my_connections = User.select("users.*, connections.connection_type_id").joins("JOIN connections ON connections.connected_user_id = users.id AND connections.user_id = #{@current_user.id}")

    @my_pending_connections = User.joins(:connection_requests).where("requested_user_id = ?", @current_user.id)
  end

  def request_response
    # Note - add a bunch of validation here later
    @current_user = User.find_by(:id => session[:user_id])

    if params[:connec_response] == "Accept"

      # Add both relations to the Connection model

        # Add the relationship for the current user
        c = Connection.new
        c.user_id = @current_user.id
        c.connected_user_id = params[:connected_user_id].to_i
        c.connection_type_id = params[:connection_type].to_i
        c.save

        # Add the relationship for the other connection
        c = Connection.new
        c.user_id = params[:connected_user_id].to_i
        c.connected_user_id = @current_user.id
        c.connection_type_id = ConnectionRequest.find_by(:user_id => params[:connected_user_id].to_i, :requested_user_id => @current_user.id).connection_type_id
        c.save

      # Delete from the ConnectionRequest model
        ConnectionRequest.find_by(:user_id => params[:connected_user_id].to_i, :requested_user_id => @current_user.id).destroy

      redirect_to "/connections", notice: "Connection Added!"
    elsif params[:connec_response] == "Decline"

      # Delete the request from the ConnectionRequest model
      ConnectionRequest.find_by(:user_id => params[:connected_user_id].to_i, :requested_user_id => @current_user.id).destroy

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

    if requested_user.present?

      cr = ConnectionRequest.new
      cr.user_id = @current_user.id
      cr.requested_user_id = User.find_by(:email => params[:request_email]).id
      cr.connection_type_id = params[:connection_type]
      cr.request_date  = Time.now
      cr.save

      redirect_to "/connections", notice: "A connection request has been sent to #{params[:request_email]}"
    elsif User.find_by(:email => params[:request_email]).nil?

      redirect_to "/connections", notice: "There is no account registered to #{params[:request_email]}. We've sent them an invitation to join."
    end

  end






end
