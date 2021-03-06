  Giftsharing::Application.routes.draw do

  root to: "welcome#home"


  devise_for :temp_users, :controllers => { registrations: 'registrations' }
  devise_for :users, :controllers => {sessions: 'sessions'}

##########################################################################


  # MY LISTS

    #CREATE
    get  "/mylists/create" => "mylists#list_create"
    get  "/mylists/:list_id/update" => "mylists#list_create"

    #READ
    get  "/mylists" => "mylists#home"
    get  "/mylists/old" => "mylists#old"

    #UPDATE
    get  "/mylists/:list_id/edit" => "mylists#list_edit"

    #DELETE
    get  "/mylists/:list_id/delete" => "mylists#list_destroy"

    #ADD / REMOVE ACESS FOR OTHER USERS
    get  "/mylists/:list_id/list_access/remove" => "mylists#list_access_remove"
    get  "/mylists/:list_id/list_access/add" => "mylists#list_access_add"

##########################################################################

  # ITEMS ON MY LISTS

    #CREATE
      get  "/mylists/:list_id/contents/add" => "mylists#item_add"

    #READ
      get  "/mylists/:list_id/contents" => "mylists#listContents"

    #UPDATE
      get  "/mylists/:list_id/contents/edit/:item_id" => "mylists#item_edit"
      get  "/mylists/:list_id/contents/update/:item_id" => "mylists#item_add"

    #DELETE
      get  "/mylists/:list_id/contents/delete/:item_id" => "mylists#item_delete"



##########################################################################

  # MY PURCHASES

    #CREATE
    get  "/sharedlists/:list_id/item/claim" => "sharedlists#claim_item"

    #READ
    get  "/purchases" => "purchases#view_my_purchases"
    get  "/sharedlists/:list_id/contents" => "sharedlists#listContents"

    #UPDATE
        # Note: By design users can claim and unclaim items. There is no direct way to "edit a  purchase without unclaiming it"

    #DELETE
    get  "/sharedlists/:list_id/purchases/delete/:item_id" => "sharedlists#unclaim_item"



##########################################################################

  # MY CONNECTIONS

    #CREATE
    get  "/connections/send_request" => "connections#send_request"
    get  "/connections/response" => "connections#request_response"

    #READ
    get  "/connections"  => "connections#home"

    #UPDATE
    get  "/connections/edit" => "connections#connection_edit"
    get  "/connections/update" => "connections#connection_update"

    #DELETE
    get  "/connections/:connection_id/delete" => "connections#connection_delete"



##########################################################################

  # USERS

    #READ
      get  "/myprofile" => "welcome#profile_view"

    #UPDATE
      get  "/myprofile/edit" => "welcome#profile_edit"
      get  "/myprofile/update" => "welcome#profile_update"

    #DELETE
      # Note: I am not currently offering a way for a user to de-activate their account

    # Confirming a temp account
      get "/confirm_account" => "welcome#confirm_acct"

##########################################################################


# Notes
  # Home page stolen from: http://startbootstrap.com/templates/full-width-pics.html



# To Do List

# Users
  # Keep the verification query string around if user enters wrong password on first try (right now would have to go back to the original email to get the link again)

# Functionality
  # Send emails later - not during http request
  # Make the generated emails better
  # Trigger the updated_at field when any item changes
  # For users signing up b/c someone has invited them, skip the 2nd email authentication step


# Cosmetics
  # Some of my buttons in tables still not centered vertically
  # Set up pagination and filters?
    # https://github.com/amatsuda/kaminari
      # Could do easier filters like his question board

# Robustness
  # Use resource routing instead of original method
  # Add database constraints to the tables
  # Go through HTML and use ruby tags instead where possible

# Security
  # Learn about SQL injection and review everything


end
