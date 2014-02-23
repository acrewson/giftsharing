Giftsharing::Application.routes.draw do

  get "/" => "welcome#home"

  get  "/mylists" => "mylists#home"
  get  "/mylists/create" => "mylists#create"
  get  "/mylists/:list_id/delete" => "mylists#destroy"
  get  "/mylists/:list_id/list" => "mylists#listContents"

end
