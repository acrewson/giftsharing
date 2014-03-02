require 'date'
require 'time'

class MylistsController < ApplicationController

  def home
    current_user = User.find_by(:id => session[:user_id])

    if current_user.present?
      @user_first_name = current_user.firstname
      @mylists = List.where("datedeleted is ? AND user_id = ?", nil, current_user.id)

      @list_types = Listtype.all
    else
      redirect_to "/login", notice: "Please login to view this page"
    end
  end

  def list_create
    list = List.new
    list.listname = params[:listname]
    list.listType_id = params[:listtype]
    list.eventdate = Date.strptime(params[:eventdate], "%m/%d/%Y")
    # Update user_id later...
    list.user_id = 1
    list.save

    redirect_to "/mylists"
  end


  def list_destroy
    list = List.find_by(id: params[:list_id])
    list.datedeleted = Time.now
    list.save
    redirect_to "/mylists"
  end

  def listContents
    @user_first_name = cookies[:firstname]
    @list_id = params[:list_id]

    list = List.find_by(id: params[:list_id])
    @myitems = Item.where(list_id: params[:list_id], date_deleted: nil)

    @listname = list.listname

    @viewable_cols = ["Item Requested", "Quantity Requested", "Request Type", ""]

    # Client.where("orders_count = ?", params[:orders])

  end


  def item_add
    #Save the user inputted information to the list
    i = Item.new
    i.description = params[:description]
    i.quantity = params[:quantity]
    i.comments = params[:comments]
    i.url = params[:url]
    i.list_id = params[:list_id]
    i.save

    redirect_to "/mylists/" + params[:list_id] + "/list"
  end


  def item_delete
    i = Item.find_by(id: params[:item_id])
    i.date_deleted = Time.now
    i.save

    redirect_to "/mylists/" + params[:list_id] + "/list"
  end


end
