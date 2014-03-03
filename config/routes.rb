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

  # Dealing with items on my lists
  get  "/mylists/:list_id/list" => "mylists#listContents"
  get  "/mylists/:list_id/list/add" => "mylists#item_add"
  get  "/mylists/:list_id/list/delete/:item_id" => "mylists#item_delete"

  # Shared Lists
  get  "/sharedlists/:list_id/list" => "sharedlists#listContents"



# To Do List

# Functionality
  # Add a way to edit an item already on the list
  # Add way for user to flag if it is an example or the exact item
  # Add a way for the user to edit the name/date of a list
  # Create way for user to share lists
  # The remember me button doesn't do anything when logging in
  # Add a "my profile" page.

# Cosmetics
  # Figure out how to specify table column widths (quantity can be smaller)
  # Create a home page

# Robustness
  # Add a bunch of logic/checks to make sure users don't abuse URL structure
  # URLs only work when user puts full path. Support www. entries


# Questions
  # How do I update in batch on the backend?
    # Chain the update_all after your where clause

end
