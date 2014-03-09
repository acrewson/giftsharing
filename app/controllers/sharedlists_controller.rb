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



    end

end


def claim_item

    # From the form, identify the item
    item_claimed = Item.find_by(:id => params[:item_claimed])
    q_claimed = params["item_#{item_claimed.id.to_s}_q_claimed"].to_i


    # Update the Purchases table
    if Purchase.find_by("item_id = ? AND user_id = ?", item_claimed.id, session[:user_id]).present?
        p = Purchase.find_by("item_id = ? AND user_id = ?", item_claimed.id, session[:user_id])
        p.date_purchased = Time.now
        p.quantity_purchased = p.quantity_purchased + q_claimed
        p.save
    else
        p = Purchase.new
        p.item_id = item_claimed.id
        p.user_id = session[:user_id]
        p.date_purchased = Time.now
        p.quantity_purchased = q_claimed
        p.save
    end

    # redirect_to the list
    redirect_to "/sharedlists/#{params[:list_id]}/contents", notice: "Your have claimed the item!"
end



def unclaim_item
    # Go back and add validation here...

    Purchase.find_by(:item_id => params[:item_id], :user_id => session[:user_id]).destroy

    redirect_to "/sharedlists/#{params[:list_id]}/contents", notice: "Your have released the item!"

end



end
