require 'date'
require 'time'

class MylistsController < ApplicationController

  def home
    @current_user = User.find_by(:id => session[:user_id])

    if @current_user.present?

      @mylists = List.where("datedeleted is ? AND user_id = ?", nil, @current_user.id)

      @lists_shared_with_me = List.joins(:shared_lists).where("shared_lists.user_id = ? and lists.datedeleted is ?", @current_user.id, nil)

    else
      redirect_to "/login", notice: "Please login to view this page"
    end
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
  end



  def list_destroy
    list = List.find_by(id: params[:list_id])
    list.datedeleted = Time.now
    list.save
    redirect_to "/mylists"
  end





  def listContents
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])


    if @selected_list.nil?
      redirect_to "/mylists", notice: "Something went wrong, please try again"
    elsif @current_user.present? && @current_user.id == @selected_list.user_id
      @user_first_name = @current_user.firstname

      @myitems = Item.where("list_id = ? AND date_deleted is ?", params[:list_id], nil)

      # Sharing with others
      @shared_users = User.joins(:shared_lists).where("shared_lists.list_id = ?", @selected_list.id)

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


    elsif @current_user.present? && @current_user.id != @selected_list.user_id
      redirect_to "/mylists", notice: "You do not have access to view that page."
    else
      redirect_to "/login", notice: "Please login to view this page"
    end


  end


  def item_add
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
    i.list_id = params[:list_id]
    i.request_type_id = params[:requst_type]
    i.save

    redirect_to "/mylists/#{params[:list_id]}/contents"
  end


  def item_delete
    i = Item.find_by(id: params[:item_id])
    i.date_deleted = Time.now
    i.save

    redirect_to "/mylists/#{params[:list_id]}/contents"
  end


  def item_edit
    @current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])
    @selected_item = Item.find_by(id: params[:item_id])
  end




  def list_access_remove

    # Come back and add security

    # For each key that starts in remove, remove the access for that person
    params.keys.each do |q|
      if q[0,6] == "remove"
        SharedList.find_by(:list_id => params[:list_id], :user_id => q[6,q.length - 6].to_i).destroy
      end
    end

    redirect_to "/mylists/#{params[:list_id]}/contents", notice: "Person removed"

  end


  def list_access_add

    # Come back and add security

    # For each key that starts in remove, remove the access for that person
    params.keys.each do |q|
      if q[0,3] == "add"
        z = SharedList.new
        z.list_id = params[:list_id]
        z.user_id = q[3,q.length - 3].to_i
        z.shared_date = Time.now
        z.save

      end
    end

    redirect_to "/mylists/#{params[:list_id]}/contents", notice: "Person added"



  end



end
