require 'date'
require 'time'

class MylistsController < ApplicationController

  def home
    current_user = User.find_by(:id => session[:user_id])

    if current_user.present?
      @user_first_name = current_user.firstname
      @mylists = List.where("datedeleted is ? AND user_id = ?", nil, current_user.id)
      # @lists_shared_with_me = current_user.shared_lists
      @lists_shared_with_me = List.joins(:shared_lists).where("shared_lists.user_id = ? and lists.datedeleted is ?", current_user.id, nil)

      @list_types = Listtype.all
    else
      redirect_to "/login", notice: "Please login to view this page"
    end
  end




  def list_create
    list = List.new
    list.listname = params[:listname]
    list.listtype_id = params[:listtype]
    list.eventdate = Date.strptime(params[:eventdate], "%m/%d/%Y")
    list.user_id = session[:user_id]
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
    current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])


    if @selected_list.nil?
      redirect_to "/mylists", notice: "Something went wrong, please try again"
    elsif current_user.present? && current_user.id == @selected_list.user_id
      @user_first_name = current_user.firstname

      @myitems = Item.where("list_id = ? AND date_deleted is ?", params[:list_id], nil)

      @viewable_cols = ["Item Requested", "Quantity Requested", "Request Type", ""]
    elsif current_user.present? && current_user.id != @selected_list.user_id
      redirect_to "/mylists", notice: "You do not have access to view that page."
    else
      redirect_to "/login", notice: "Please login to view this page"
    end


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
