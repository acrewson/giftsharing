class SharedlistsController < ApplicationController

def listContents
    current_user = User.find_by(:id => session[:user_id])
    @selected_list = List.find_by(id: params[:list_id])

    @permission = List.joins(:shared_lists).where("lists.id = ? and shared_lists.user_id = ? and lists.datedeleted is ?", params[:list_id], current_user.id, nil)


    if @permission.count == 0
       redirect_to "/mylists", notice: "Something went wrong, please try again"
    else

    @shared_items = Item.where("list_id = ? AND date_deleted is ?", params[:list_id], nil)

    @viewable_cols = ["Item Requested", "Request Type", "Quantity Requested", "Quantity Needed", "Claim this item!"]

    #   @viewable_cols = ["Item Requested", "Quantity Requested", "Request Type", ""]
    end

end





end
