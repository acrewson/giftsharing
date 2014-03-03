require 'Date'


State.destroy_all

["AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"].each do |state_abbrev|
    s = State.new
    s.state = state_abbrev
    s.save
end

User.destroy_all

u = [
  {
    :firstname => "Andy",
    :lastname => "Crewson",
    :birthdate => "10/10/1986",
    :address => "1000 Main St Apt 1",
    :city => "Evanston",
    :state_id => State.find_by(state: "IL").id,
    :zip => 60201,
    :email => "test@email.com",
    :password => "password",
  },
  {
    :firstname => "Jordan",
    :lastname => "Smith",
    :birthdate => "01/09/1978",
    :address => "1000 Maple St Apt 9",
    :city => "Cambridge",
    :state_id => State.find_by(state: "MA").id,
    :zip => 12345,
    :email => "test2@email.com",
    :password => "password",
  },
  {
    :firstname => "Steve",
    :lastname => "Smith",
    :birthdate => "06/09/1978",
    :address => "1000 Peach St Apt 1",
    :city => "Atlanta",
    :state_id => State.find_by(state: "GA").id,
    :zip => 23456,
    :email => "test3@email.com",
    :password => "password",
  }
]


u.each do |user|
  a = User.new
  a.firstname = user[:firstname]
  a.lastname = user[:lastname]
  a.birthdate = user[:birthdate]
  a.address = user[:address]
  a.city = user[:city]
  a.state_id = user[:state_id]
  a.zip = user[:zip]
  a.email = user[:email]
  a.password = user[:password]
  a.save
end







Listtype.destroy_all
q = ["Birthday", "Christmas","Wedding","Baby Shower"].sort
q.push("Other")
q.each do |listtypeName|
    p =Listtype.new
    p.listtype = listtypeName
    p.save
end






Relationtype.destroy_all

q = ["Husband","Wife","Brother","Sister","Friend","Mother","Father","Mother-in-law","Father-in-law","Daughter","Son","Son-in-law","Daughter-in-law","Brother-in-law","Sister-in-law","Grandson","Granddaughter","Grandmother", "Grandfather", "Aunt", "Uncle", "Niece", "Nephew"].sort
q.push("Other")
q.each do |r|
    p = Relationtype.new
    p.relation_type_desc = r
    p.save
end







List.destroy_all

l = [
  {
    :listname => "Andy's Birthday List 2014",
    :listType_id => Listtype.find_by(listtype: "Birthday").id,
    :eventdate => "10/10/2014",
    :user_id => User.find_by(email: "test@email.com").id,
  },
  {
    :listname => "Jordan's Christmas List 2014",
    :listType_id => Listtype.find_by(listtype: "Christmas").id,
    :eventdate => "12/25/2014",
    :user_id => User.find_by(email: "test2@email.com").id,
  },
  {
    :listname => "Steve's Wedding Registry",
    :listType_id => Listtype.find_by(listtype: "Wedding").id,
    :eventdate => "07/29/2014",
    :user_id => User.find_by(email: "test3@email.com").id,
  }
]


l.each do |list|
  a = List.new
  a.listname = list[:listname]
  a.listType_id = list[:listType_id]
  a.eventdate = Date.strptime(list[:eventdate], "%m/%d/%Y")
  a.user_id = list[:user_id]
  a.save
end



SharedList.destroy_all

s = [
  {
    :shared_date => "02/22/2014",
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id,
    :user_id => User.find_by(firstname: "Jordan").id,
  },
  {
    :shared_date => "02/26/2014",
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id,
    :user_id => User.find_by(firstname: "Steve").id,
  },
  {
    :shared_date => "03/02/2014",
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id,
    :user_id => User.find_by(firstname: "Andy").id,
  }
]


s.each do |share|
  x = SharedList.new
  x.shared_date = Date.strptime(share[:shared_date], "%m/%d/%Y")
  x.list_id = share[:list_id]
  x.user_id = share[:user_id]
  x.save
end



Item.destroy_all

i = [
  {
    :description => "Basketball",
    :quantity => 1,
    :comments => "I love to play basketball every day.",
    :url => "http://www.amazon.com/Spalding-NBA-Street-Basketball-Official/dp/B0009VELG4/ref=sr_1_1?ie=UTF8&qid=1393813830&sr=8-1&keywords=basketball",
    :quantity_purchased => 0,
    :request_type => 1,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Shirt",
    :quantity => 1,
    :comments => "I need new work clothes",
    :url => "http://bananarepublic.gap.com/browse/product.do?cid=56729&vid=1&pid=958408002",
    :quantity_purchased => 0,
    :request_type => 2,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Kindle Fire",
    :quantity => 1,
    :comments => "I love tablets",
    :url => "http://www.amazon.com/kindle-fire-hdx-best-movie-tablet-8.9/dp/B00BHJRYYS/ref=sr_1_1?ie=UTF8&qid=1393814366&sr=8-1&keywords=kindle",
    :quantity_purchased => 0,
    :request_type => 1,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Kellogg Tuition",
    :quantity => 1,
    :comments => "Kellogg is very expensive!",
    :url => "http://kellogg.northwestern.edu/",
    :quantity_purchased => 0,
    :request_type => 2,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "The Signal and the Noise",
    :quantity => 3,
    :comments => "I am interested in statistical modeling",
    :url => "http://www.amazon.com/Signal-Noise-Many-Predictions-Fail/dp/159420411X/ref=sr_1_1?s=books&ie=UTF8&qid=1393814422&sr=1-1&keywords=signal+and+the+noise",
    :quantity_purchased => 1,
    :request_type => 2,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
]

i.each do |item|
  it = Item.new
  it.description = item[:description]
  it.quantity = item[:quantity]
  it.comments = item[:comments]
  it.url = item[:url]
  it.quantity_purchased = item[:quantity_purchased]
  it.request_type = item[:request_type]
  it.list_id = item[:list_id]
  it.save
end


RequestType.destroy_all

z = RequestType.new
z.request_type_description = 'Example'
z.save

z = RequestType.new
z.request_type_description = 'Exact Request'
z.save

