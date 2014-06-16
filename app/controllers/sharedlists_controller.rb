require 'date'
require 'time'

class SharedlistsController < ApplicationController

#####################################################################

    # This will require that a user is logged in before executing any method in this controller

  before_action :authenticate_user!

  # The rails guides have "private" here - but this breaks things. Why?

  before_action :num_requests

  def num_requests
    @num_pending_req = ConnectionRequest.where("requested_user_id = ?", current_user.id).count
  end

#####################################################################




    def listContents
        @current_user = User.find_by(:id => session[:user_id])
        @selected_list = List.find_by(id: params[:list_id])

        @permission = List.joins(:shared_lists).where("lists.id = ? and shared_lists.user_id = ? and lists.datedeleted is ?", params[:list_id], @current_user.id, nil)

        if @permission.count == 0
           redirect_to "/mylists", notice: "Something went wrong, please try again"
        else

        @shared_items = @selected_list.items.where("date_deleted is ?", nil)

        @claimed_items_by_user = Purchase.joins(:item).where("purchases.user_id = ? and items.date_deleted is ? and list_id = ?", @current_user.id, nil, params[:list_id])

        end

    end


    def claim_item

        # To avoid URL hacking, ensure user has access to requested list
        @current_user = User.find_by(:id => session[:user_id])
        @selected_list = List.find_by(id: params[:list_id])

        @permission = List.joins(:shared_lists).where("lists.id = ? and shared_lists.user_id = ? and lists.datedeleted is ?", params[:list_id], @current_user.id, nil)

        if @permission.count == 0
           redirect_to "/mylists", notice: "Something went wrong, please try again" and return
        end


# /sharedlists/3/item/claim?item_6_q_claimed=1&item_claimed=6&item_7_q_claimed=&item_8_q_claimed=&item_10_q_claimed=&item_11_q_claimed=&item_12_q_claimed=

        # From the form, identify the item
        item_claimed = Item.find_by(:id => params[:item_claimed])

        # Ensure item actually exists
        if item_claimed.nil?
            redirect_to "/sharedlists/#{params[:list_id]}/contents", notice: "Something went wrong, please try again" and return
        # Ensure item is on this list
        elsif item_claimed.list_id != @selected_list.id
            redirect_to "/sharedlists/#{params[:list_id]}/contents", notice: "Something went wrong, please try again" and return
        else

            # Update the Purchases table
            q_claimed = params["item_#{item_claimed.id.to_s}_q_claimed"].to_i

            # First validate the quantity entered
            if q_claimed <=0
                redirect_to "/sharedlists/#{params[:list_id]}/contents", notice: "Please claim a positive number" and return
            elsif q_claimed > item_claimed.quantity_requested
                redirect_to "/sharedlists/#{params[:list_id]}/contents", notice: "Please claim a quantity less than or equal to #{item_claimed.quantity_requested}" and return
            end


            # Record the purchase
            if Purchase.find_by("item_id = ? AND user_id = ?", item_claimed.id, session[:user_id]).present?
                p = Purchase.find_by("item_id = ? AND user_id = ?", item_claimed.id, session[:user_id])
                p.quantity_purchased = p.quantity_purchased + q_claimed
            else
                p = Purchase.new
                p.quantity_purchased = q_claimed
                p.item_id = item_claimed.id
                p.user_id = session[:user_id]
            end

            p.date_purchased = Time.now
            p.save

        end

        # redirect_to the list
        redirect_to "/sharedlists/#{params[:list_id]}/contents", notice: "Your have claimed the item!"
    end



    def unclaim_item
        # To avoid URL hacking, ensure user has actually purchased the item to be deleted
        @current_user = User.find_by(:id => session[:user_id])

        p = Purchase.find_by(:item_id => params[:item_id], :user_id => session[:user_id])

        if p.present?
            Purchase.find_by(:item_id => params[:item_id], :user_id => session[:user_id]).destroy

            redirect_to "/sharedlists/#{params[:list_id]}/contents", notice: "Your have released the item!"
        else
            redirect_to "/mylists", notice: "Something went wrong, please try again."
        end

    end



end
