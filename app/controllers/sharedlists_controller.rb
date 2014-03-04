require 'date'
require 'time'

class SharedlistsController < ApplicationController

def listContents
    current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    @permission = List.joins(:shared_lists).where("lists.id = ? and shared_lists.user_id = ? and lists.datedeleted is ?", params[:list_id], current_user.id, nil)


    if @permission.count == 0
       redirect_to "/mylists", notice: "Something went wrong, please try again"
    else

    @shared_items = Item.where("list_id = ? AND date_deleted is ?", params[:list_id], nil)

    @claimed_items_by_user = Purchase.joins(:item).where("purchases.user_id = ? and items.date_deleted is ?", current_user.id, nil)

    @viewable_cols = ["Item Requested", "Request Type", "Quantity Requested", "Quantity Needed", "Claim this item!"]

    @viewable_cols_purchases = ["Item Requested", "Quantity Claimed", "Date Claimed", ""]

    end

end


def claim_item
    # Update the quantity_purchased column in the Item table
    z = Item.find_by(id: params[:item_id])
    z.quantity_purchased = z.quantity_purchased + params[:q_claimed].to_i
    z.save

    # Update the Purchases table
    if Purchase.find_by("item_id = ? AND user_id = ?", params[:item_id], session[:user_id]).present?
        p = Purchase.find_by("item_id = ? AND user_id = ?", params[:item_id], session[:user_id])
        p.date_purchased = Time.now
        p.quantity_purchased = p.quantity_purchased + params[:q_claimed].to_i
        p.save
    else
        p = Purchase.new
        p.item_id = params[:item_id]
        p.user_id = session[:user_id]
        p.date_purchased = Time.now
        p.quantity_purchased = params[:q_claimed].to_i
        p.save
    end





    # redirect_to the list
    redirect_to "/sharedlists/" + params[:list_id] + "/list", notice: "Your have claimed the item!"
end





end
