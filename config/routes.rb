Giftsharing::Application.routes.draw do

  root "welcome#home"

##########################################################################

  # LOGGING IN / OUT

    get "/login/authenticate" => "session#authenticate"
    get "/login/authenticate/:sec_verif" => "session#authenticate"
    get "/logout" => "session#destroy"

##########################################################################

  # MY LISTS

    #CREATE
    get  "/mylists/create" => "mylists#list_create"
    get  "/mylists/:list_id/update" => "mylists#list_create"

    #READ
    get  "/mylists" => "mylists#home"

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

    #CREATE
      get "/create_account" => "welcome#create_account"
      get  "/signup"  => "users#create_new_user"

    #READ
      get  "/myprofile" => "users#profile_view"

    #UPDATE
      get  "/myprofile/edit" => "users#profile_edit"
      get  "/myprofile/update" => "users#profile_update"

    #DELETE
      # Note: I am not currently offering a way for a user to de-activate their account

##########################################################################



# Questions for Jeff

  # How do I end the user's session when the tab/browser closes?
    # Create an encrypted cookie and then use logic: cookies.signed[:remember_me] = 5
    # Make sure to clear this out on sign out

  # Got email working, but how do I send a unique link to verify identity?
    # require 'securerandom'
    # SecureRandom.urlsafe_base64
    # Add a column to users table, and then verify against this too

  # How to set up pagination and filters?
    # https://github.com/amatsuda/kaminari
    # Could do easier filters like his question board


# Notes
  # Home page stolen from: http://startbootstrap.com/templates/full-width-pics.html



# To Do List

# Functionality
  # The remember me button doesn't do anything when logging in
  # Make the generated emails better
  # Trigger the updated_at field when any item changes
  # For users signing up b/c someone has invited them, skip the 2nd email authentication step

# Cosmetics
  # Some of my buttons in tables still not centered vertically
  # Home page - don't show login form if user is logged in - way to access home page

# Robustness
  # Add database constraints to the tables
  # Go through HTML and use ruby tags instead where possible

# Security
  # Learn about SQL injection and review everything


end
