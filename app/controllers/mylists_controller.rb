require 'date'
require 'time'

class MylistsController < ApplicationController

  def home
    cookies[:firstname] = "Andy"
    @user_first_name = cookies[:firstname]
    @mylists = List.where(datedeleted: nil)

    @list_types = Listtype.all

  end

  def create
    list = List.new
    list.listname = params[:listname]
    list.listType_id = params[:listtype]
    list.eventdate = Date.strptime(params[:eventdate], "%m/%d/%Y")
    # Update user_id later...
    list.user_id = 1
    list.save

    redirect_to "/mylists"
  end


  def destroy
    list = List.find_by(id: params[:list_id])
    list.datedeleted = Time.now
    list.save
    redirect_to "/mylists"
  end

  def listContents

  end




end
