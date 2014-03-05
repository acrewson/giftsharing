require 'Time'


State.destroy_all

["AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"].each do |state_abb|
    s = State.new
    s.state_abbrev = state_abb
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
    :state_id => State.find_by(state_abbrev: "IL").id,
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
    :state_id => State.find_by(state_abbrev: "MA").id,
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
    :state_id => State.find_by(state_abbrev: "GA").id,
    :zip => 23456,
    :email => "test3@email.com",
    :password => "password",
  },
  {
    :firstname => "DJ",
    :lastname => "Kelly",
    :birthdate => "03/09/1980",
    :address => "1000 Westcroft Dr.",
    :city => "Toledo",
    :state_id => State.find_by(state_abbrev: "OH").id,
    :zip => 43560,
    :email => "test4@email.com",
    :password => "password",
  },
  {
    :firstname => "David",
    :lastname => "Chung",
    :birthdate => "02/03/1965",
    :address => "2100 Lee Hwy",
    :city => "Arlington",
    :state_id => State.find_by(state_abbrev: "VA").id,
    :zip => 22209,
    :email => "test5@email.com",
    :password => "password",
  },
  {
    :firstname => "Jon",
    :lastname => "Scheyer",
    :birthdate => "06/09/1987",
    :address => "1000 McQueen Dr",
    :city => "Durham",
    :state_id => State.find_by(state_abbrev: "NC").id,
    :zip => 22209,
    :email => "test6@email.com",
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
  a.listtype_id = list[:listType_id]
  a.eventdate = Date.strptime(list[:eventdate], "%m/%d/%Y")
  a.user_id = list[:user_id]
  a.save
end



SharedList.destroy_all

s = [
  {
    :shared_date => "02/22/2014",
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id,
    :user_id => User.find_by(email: "test2@email.com").id,
  },
  {
    :shared_date => "02/26/2014",
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id,
    :user_id => User.find_by(email: "test3@email.com").id,
  },
  {
    :shared_date => "03/02/2014",
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id,
    :user_id => User.find_by(email: "test@email.com").id,
  }
]


s.each do |share|
  x = SharedList.new
  x.shared_date = Date.strptime(share[:shared_date], "%m/%d/%Y")
  x.list_id = share[:list_id]
  x.user_id = share[:user_id]
  x.save
end


RequestType.destroy_all

rt = ["Example", "Exact Request"]

rt.each do |r|

  z = RequestType.new
  z.request_type_description = r
  z.save

end




Item.destroy_all

i = [
  {
    :description => "Basketball",
    :quantity => 1,
    :comments => "I love to play basketball every day.",
    :url => "http://www.amazon.com/Spalding-NBA-Street-Basketball-Official/dp/B0009VELG4/ref=sr_1_1?ie=UTF8&qid=1393813830&sr=8-1&keywords=basketball",
    :quantity_purchased => 0,
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Shirt",
    :quantity => 1,
    :comments => "I need new work clothes",
    :url => "http://bananarepublic.gap.com/browse/product.do?cid=56729&vid=1&pid=958408002",
    :quantity_purchased => 0,
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Kindle Fire",
    :quantity => 1,
    :comments => "I love tablets",
    :url => "http://www.amazon.com/kindle-fire-hdx-best-movie-tablet-8.9/dp/B00BHJRYYS/ref=sr_1_1?ie=UTF8&qid=1393814366&sr=8-1&keywords=kindle",
    :quantity_purchased => 0,
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Kellogg Tuition",
    :quantity => 1,
    :comments => "Kellogg is very expensive!",
    :url => "http://kellogg.northwestern.edu/",
    :quantity_purchased => 0,
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "The Signal and the Noise",
    :quantity => 3,
    :comments => "I am interested in statistical modeling",
    :url => "http://www.amazon.com/Signal-Noise-Many-Predictions-Fail/dp/159420411X/ref=sr_1_1?s=books&ie=UTF8&qid=1393814422&sr=1-1&keywords=signal+and+the+noise",
    :quantity_purchased => 1,
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Basketball",
    :quantity => 1,
    :comments => "I love to play basketball every day.",
    :url => "http://www.amazon.com/Spalding-NBA-Street-Basketball-Official/dp/B0009VELG4/ref=sr_1_1?ie=UTF8&qid=1393813830&sr=8-1&keywords=basketball",
    :quantity_purchased => 0,
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
  {
    :description => "Road Bike",
    :quantity => 1,
    :comments => "I love to ride",
    :url => "http://www.trekbikes.com/us/en/bikes/road/performance_race/madone_5_series/",
    :quantity_purchased => 0,
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
]

i.each do |item|
  it = Item.new
  it.description = item[:description]
  it.quantity_requested = item[:quantity]
  it.comments = item[:comments]
  it.url = item[:url]
  it.quantity_purchased = item[:quantity_purchased]
  it.request_type_id = item[:request_type]
  it.list_id = item[:list_id]
  it.save
end



ConnectionType.destroy_all

q = ["Husband","Wife","Brother","Sister","Friend","Mother","Father","Mother-in-law","Father-in-law","Daughter","Son","Son-in-law","Daughter-in-law","Brother-in-law","Sister-in-law","Grandson","Granddaughter","Grandmother", "Grandfather", "Aunt", "Uncle", "Niece", "Nephew"].sort
q.push("Other")
q.each do |r|
    p = ConnectionType.new
    p.connection_description = r
    p.save
end


Connection.destroy_all

c = [
  {
    :user_id => User.find_by(email: "test@email.com").id,
    :connected_user_id => User.find_by(email: "test2@email.com").id,
    :connection_type_id => ConnectionType.find_by(connection_description: "Friend").id,
  },
  {
    :user_id => User.find_by(email: "test@email.com").id,
    :connected_user_id => User.find_by(email: "test3@email.com").id,
    :connection_type_id => ConnectionType.find_by(connection_description: "Brother-in-law").id,
  },
  {
    :user_id => User.find_by(email: "test2@email.com").id,
    :connected_user_id => User.find_by(email: "test@email.com").id,
    :connection_type_id => ConnectionType.find_by(connection_description: "Friend").id,
  }
]

c.each do |connec|
  co = Connection.new
  co.user_id = connec[:user_id]
  co.connected_user_id = connec[:connected_user_id]
  co.connection_type_id = connec[:connection_type_id]
  co.save
end


ConnectionRequest.destroy_all

cr =
[
  {
    :user_id => User.find_by(email: "test4@email.com").id,
    :requested_user_id => User.find_by(email: "test@email.com").id,
    :request_date => "03/04/2014",
    :connection_type_id => ConnectionType.find_by(connection_description: "Friend").id,
  },
  {
    :user_id => User.find_by(email: "test5@email.com").id,
    :requested_user_id => User.find_by(email: "test@email.com").id,
    :request_date => "03/05/2014",
    :connection_type_id => ConnectionType.find_by(connection_description: "Friend").id,
  }
]

cr.each do |request|
  r = ConnectionRequest.new
  r.user_id = request[:user_id]
  r.requested_user_id = request[:requested_user_id]
  r.request_date = Date.strptime(request[:request_date], "%m/%d/%Y")
  r.connection_type_id = request[:connection_type_id]
  r.save
end







