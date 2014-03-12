require 'date'
require 'time'

class MylistsController < ApplicationController


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
    # @current_user = User.find_by(:id => session[:user_id])

    @mylists = @current_user.lists.where("datedeleted is ?", nil)

    @lists_shared_with_me = List.joins(:shared_lists).where("shared_lists.user_id = ? and lists.datedeleted is ?", @current_user.id, nil)

  end




  def list_create
    if List.find_by(:id => params[:list_id]).present?
      list = List.find_by(:id => params[:list_id])
    else
      list = List.new
    end

    list.listname = params[:listname]
    list.listtype_id = params[:listtype]
    list.eventdate = Date.strptime(params[:eventdate], "%m/%d/%Y")
    list.user_id = session[:user_id]
    list.save

    redirect_to "/mylists"
  end



  def list_edit
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    # Make sure user owns this list
    if @current_user.lists.find_by(:id => @selected_list.id).nil?
      redirect_to "/mylists", notice: "Something went wrong, please try again"
    end

  end



  def list_destroy

    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    # Make sure user owns this list
    if @current_user.lists.find_by(:id => @selected_list.id).nil?
      redirect_to "/mylists", notice: "Something went wrong, please try again" and return
    end

    list = List.find_by(id: params[:list_id])
    list.datedeleted = Time.now
    list.save
    redirect_to "/mylists"
  end



  def listContents
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    if @current_user.lists.find_by(:id => @selected_list.id).nil?
      redirect_to "/mylists", notice: "You do not have access to view that page." and return

    else

      @myitems = @selected_list.items.where("date_deleted is ?", nil)

      # Sharing with others
      @shared_users = @selected_list.users

      @potential_users = User.select("cu.*").joins("
                JOIN connections as c
                  ON users.id = c.user_id
                  AND c.user_id = #{@current_user.id}
                JOIN users as cu
                  ON c.connected_user_id = cu.id
                LEFT OUTER JOIN shared_lists as sl
                  ON c.connected_user_id = sl.user_id
                  AND sl.list_id = #{@selected_list.id}")
        .where("sl.list_id is ?", nil)

    end


  end


  def item_add
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    # Make sure user owns this list
    if @current_user.lists.find_by(:id => @selected_list.id).nil?
      redirect_to "/mylists", notice: "Something went wrong, please try again" and return
    end


    if Item.find_by(:id => params[:item_id]).present?
      i = Item.find_by(:id => params[:item_id])
    else
      i = Item.new
    end

    #Save the user inputted information to the list
    i.description = params[:description]
    i.quantity_requested = params[:quantity]
    i.comments = params[:comments]
    i.url = params[:url]

    if params[:url][0,7] != "http://"
      i.url = "http://" + i.url
    end

    i.list_id = params[:list_id]
    i.request_type_id = params[:requst_type]
    i.save

    redirect_to "/mylists/#{params[:list_id]}/contents"
  end


  def item_delete
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    # Make sure user owns this list
    if @current_user.lists.find_by(:id => @selected_list.id).nil?
      redirect_to "/mylists", notice: "Something went wrong, please try again" and return
    end

    i = Item.find_by(id: params[:item_id])
    i.date_deleted = Time.now
    i.save

    redirect_to "/mylists/#{params[:list_id]}/contents"
  end


  def item_edit
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    # Make sure user owns this list
    if @current_user.lists.find_by(:id => @selected_list.id).nil?
      redirect_to "/mylists", notice: "Something went wrong, please try again" and return
    end

    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])
    @selected_item = Item.find_by(id: params[:item_id])
  end




  def list_access_remove

    # First make sure the user actually owns the list
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    # Make sure user owns this list
    if @current_user.lists.find_by(:id => @selected_list.id).nil?
      redirect_to "/mylists", notice: "Something went wrong, please try again" and return
    end


    # For each key that starts in remove, remove the access for that person
    params.keys.each do |q|
      if q[0,6] == "remove"
        removal_id = q[6,q.length - 6].to_i

        # Check that user has access and is connected
        c = @current_user.connections.find_by(:connected_user_id => removal_id)
        sl = SharedList.find_by(:list_id => @selected_list, :user_id => removal_id)

        if c.present? and sl.present?
          SharedList.find_by(:list_id => params[:list_id], :user_id => removal_id).destroy
        else
          redirect_to "/mylists/#{params[:list_id]}/contents", notice: "Something went wrong, please try again" and return
        end
      end
    end

    redirect_to "/mylists/#{params[:list_id]}/contents", notice: "Access has been removed"

  end


  def list_access_add

    # First make sure the user actually owns the list
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    # Make sure user owns this list
    if @current_user.lists.find_by(:id => @selected_list.id).nil?
      redirect_to "/mylists/", notice: "Something went wrong, please try again" and return
    end

    # For each key that starts in add, add the access for that person
    params.keys.each do |q|
      if q[0,3] == "add"
        add_id = q[3,q.length - 3].to_i

        # Check addition is a connection (prevent url hacking)
        c = @current_user.connections.find_by(:connected_user_id => add_id)

        if c.present?
          z = SharedList.new
          z.list_id = params[:list_id]
          z.user_id = add_id
          z.shared_date = Time.now
          z.save
        else
          redirect_to "/mylists/#{params[:list_id]}/contents", notice: "Something went wrong, please try again" and return
        end

      end
    end

    redirect_to "/mylists/#{params[:list_id]}/contents", notice: "Access has been granted"


  end



end
