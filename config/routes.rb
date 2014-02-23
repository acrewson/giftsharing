Giftsharing::Application.routes.draw do

  get "/" => "welcome#home"

  # Dealing with my lists
  get  "/mylists" => "mylists#home"
  get  "/mylists/create" => "mylists#list_create"
  get  "/mylists/:list_id/delete" => "mylists#list_destroy"

  # Dealing with items on lists
  get  "/mylists/:list_id/list" => "mylists#listContents"
  get  "/mylists/:list_id/list/add" => "mylists#item_add"
  get  "/mylists/:list_id/list/delete/:item_id" => "mylists#item_delete"


# To Do List
  # Open links in new tab -- should i use link_to or the "a" html tag?
  # Add a way to edit an item already on the list
  # Add way for user to flag if it is an example or the exact item
  # Figure out how to specify table column widths (quantity can be smaller)
  # Add a bunch of logic/checks to make sure users don't abuse URL structure
  # Learn how to do prettier date formatting on front end
  # Add a way for the user to edit the name/date of a list
  # URLs only work when user puts full path. Support www. entries
  # Incorporate concept of users - I only should have access to MY lists
  # Create way for user to share lists
  # On my home page, allow me to see lists shared with me
  # Allow me to see a shared list and items need purchasing

# Questions
  # How do I update in batch on the backend?

end
