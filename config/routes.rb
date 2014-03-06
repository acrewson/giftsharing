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
  get  "/mylists/:list_id/list_access/remove" => "mylists#list_access_remove"
  get  "/mylists/:list_id/list_access/add" => "mylists#list_access_add"

  # Dealing with items on my lists
  get  "/mylists/:list_id/contents" => "mylists#listContents"
  get  "/mylists/:list_id/contents/add" => "mylists#item_add"
  get  "/mylists/:list_id/contents/delete/:item_id" => "mylists#item_delete"

  # Shared Lists
  get  "/sharedlists/:list_id/list" => "sharedlists#listContents"
  get  "/sharedlists/:list_id/item/:item_id" => "sharedlists#claim_item"


  # Connections
  get  "/connections"  => "connections#home"
  get  "/connections/response/:connected_user_id" => "connections#request_response"
  get  "/connections/send_request" => "connections#send_request"

  # Users
  get  "/signup"  => "users#create_new_user"


# To Do List

# Functionality
  # Add a way to edit an item already on the list
  # Add way for user to flag if it is an example or the exact item
  # Add a way for the user to edit the name/date of a list
  # The remember me button doesn't do anything when logging in
  # Add a "my profile" page.
  # Instead of using quantity_purchased from items table, sum up from purchases table
  # Be able to generate emails and invite people to join

# Cosmetics
  # Figure out how to specify table column widths (quantity can be smaller)
  # Create a home page
  # Figure out how to center text in rows
  # Highlight row when hovering over it?

# Robustness
  # Add a bunch of logic/checks to make sure users don't abuse URL structure
  # Add logic around friend requests
  # URLs only work when user puts full path. Support www. entries
  # Add database constraints to the tables
  # Go back and use #{} instead of adding strings
  # Go through HTML and use ruby tags instead where possible
  # Organize around CRUD framework - fill holes as needed

# Security
  # Go through everything and make sure URL paths can't be exploited
  # Learn about SQL injection and review everything


end
