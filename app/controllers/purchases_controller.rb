class PurchasesController < ApplicationController

    def view_my_purchases
        @current_user = User.find_by(:id => session[:user_id])

    end

end
