Giftsharing::Application.routes.draw do

  root "welcome#home"

##########################################################################

  # LOGGING IN / OUT
    get "/login" => "session#login"
    get "/login/authenticate" => "session#authenticate"
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
      get  "/signup"  => "users#create_new_user"

    #READ
      get  "/myprofile" => "users#view_profile"

    #UPDATE

    #DELETE
      # Note: I am not currently offering a way for a user to de-activate their account

##########################################################################





    #CREATE

    #READ

    #UPDATE

    #DELETE





# To Do List

# Functionality
  # The remember me button doesn't do anything when logging in
  # Add a "my profile" page.
  # Through email verification make sure user owns given email address
  # Add a my purchases tab to top

# Cosmetics
  # Create a home page
  # Some of my buttons in tables still not centered vertically
  # Make sure sections are dynamically hidden if empty and act intelligently

# Robustness
  # Add a bunch of logic/checks to make sure users don't abuse URL structure
  # URLs only work when user puts full path. Support www. entries
  # Add database constraints to the tables
  # Go back and use #{} instead of adding strings
  # Go through HTML and use ruby tags instead where possible
  # Organize around CRUD framework - fill holes as needed
  # Make sure email address entries are legit

# Security
  # Go through everything and make sure URL paths can't be exploited
  # Learn about SQL injection and review everything


end
