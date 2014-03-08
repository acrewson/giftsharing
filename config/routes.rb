Giftsharing::Application.routes.draw do

  root "welcome#home"

  # Loggin in / out
  get "/login" => "session#login"
  get "/login/authenticate" => "session#authenticate"
  get "/logout" => "session#destroy"

  # Dealing with my lists
  get  "/mylists" => "mylists#home"
  get  "/mylists/create" => "mylists#list_create"
  get  "/mylists/:list_id/delete" => "mylists#list_destroy"
  get  "/mylists/:list_id/edit" => "mylists#list_edit"
  get  "/mylists/:list_id/update" => "mylists#list_create"
  get  "/mylists/:list_id/list_access/remove" => "mylists#list_access_remove"
  get  "/mylists/:list_id/list_access/add" => "mylists#list_access_add"

  # Dealing with items on my lists
  get  "/mylists/:list_id/contents" => "mylists#listContents"
  get  "/mylists/:list_id/contents/add" => "mylists#item_add"
  get  "/mylists/:list_id/contents/delete/:item_id" => "mylists#item_delete"
  get  "/mylists/:list_id/contents/edit/:item_id" => "mylists#item_edit"
  get  "/mylists/:list_id/contents/update/:item_id" => "mylists#item_add"

  # Purchases on Shared Lists
  get  "/sharedlists/:list_id/contents" => "sharedlists#listContents"
  get  "/sharedlists/:list_id/item/:item_id" => "sharedlists#claim_item"
  get  "/sharedlists/:list_id/purchases/delete/:item_id" => "sharedlists#unclaim_item"


  # Connections
  get  "/connections"  => "connections#home"
  get  "/connections/response/:connected_user_id" => "connections#request_response"
  get  "/connections/send_request" => "connections#send_request"

  # Users
  get  "/signup"  => "users#create_new_user"


# To Do List

# Functionality
  # The remember me button doesn't do anything when logging in
  # Add a "my profile" page.
  # Be able to generate emails and invite people to join
  # Through email verification make sure user owns given email address
  # Add a my purchases tab to top
  # Buttons in tables don't work first time hitting page (have to refresh)

# Cosmetics
  # Create a home page
  # Some of my buttons in tables still not centered vertically

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
