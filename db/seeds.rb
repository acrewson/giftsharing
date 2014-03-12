require 'Time'


State.destroy_all

["AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY", "Outside USA"].each do |state_abb|
    s = State.new
    s.state_abbrev = state_abb
    s.save
end



Gender.destroy_all

["Male", "Female"].each do |g|
  gd = Gender.new
  gd.gender_name = g
  gd.save
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
    :zip => "60201",
    :email => "test@email.com",
    :password => "password",
    :gender => Gender.find_by(:gender_name => "Male"),
  },
  {
    :firstname => "Jordan",
    :lastname => "Smith",
    :birthdate => "01/09/1978",
    :address => "1000 Maple St Apt 9",
    :city => "Cambridge",
    :state_id => State.find_by(state_abbrev: "MA").id,
    :zip => "12345",
    :email => "test2@email.com",
    :password => "password",
    :gender => Gender.find_by(:gender_name => "Male"),
  },
  {
    :firstname => "Steve",
    :lastname => "Smith",
    :birthdate => "06/09/1978",
    :address => "1000 Peach St Apt 1",
    :city => "Atlanta",
    :state_id => State.find_by(state_abbrev: "GA").id,
    :zip => "23456",
    :email => "test3@email.com",
    :password => "password",
    :gender => Gender.find_by(:gender_name => "Male"),
  },
  {
    :firstname => "DJ",
    :lastname => "Kelly",
    :birthdate => "03/09/1980",
    :address => "1000 Westcroft Dr.",
    :city => "Toledo",
    :state_id => State.find_by(state_abbrev: "OH").id,
    :zip => "43560",
    :email => "test4@email.com",
    :password => "password",
    :gender => Gender.find_by(:gender_name => "Male"),
  },
  {
    :firstname => "David",
    :lastname => "Chung",
    :birthdate => "02/03/1965",
    :address => "2100 Lee Hwy",
    :city => "Arlington",
    :state_id => State.find_by(state_abbrev: "VA").id,
    :zip => "22209",
    :email => "test5@email.com",
    :password => "password",
    :gender => Gender.find_by(:gender_name => "Male"),
  },
  {
    :firstname => "Jon",
    :lastname => "Scheyer",
    :birthdate => "06/09/1987",
    :address => "1000 McQueen Dr",
    :city => "Durham",
    :state_id => State.find_by(state_abbrev: "NC").id,
    :zip => "22209",
    :email => "test6@email.com",
    :password => "password",
    :gender => Gender.find_by(:gender_name => "Male"),
  },
  {
    :firstname => "Kyle",
    :lastname => "Singler",
    :birthdate => "6/23/1987",
    :address => "2222 Main St.",
    :city => "Portland",
    :state_id => State.find_by(state_abbrev: "OR").id,
    :zip => "45678",
    :email => "test7@email.com",
    :password => "password",
    :gender => Gender.find_by(:gender_name => "Male"),
  },
  {
    :firstname => "Julia",
    :lastname => "Crewson",
    :birthdate => "9/24/1984",
    :address => "2222 Main St.",
    :city => "Evanston",
    :state_id => State.find_by(state_abbrev: "IL").id,
    :zip => "60201",
    :email => "julia@email.com",
    :password => "password",
    :gender => Gender.find_by(:gender_name => "Female"),
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
  a.gender = user[:gender]
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
    :listname => "Andy's Christmas List 2014",
    :listType_id => Listtype.find_by(listtype: "Christmas").id,
    :eventdate => "12/25/2014",
    :user_id => User.find_by(email: "test@email.com").id,
  },
  {
    :listname => "Jordan's Christmas List 2014",
    :listType_id => Listtype.find_by(listtype: "Christmas").id,
    :eventdate => "12/25/2014",
    :user_id => User.find_by(email: "test2@email.com").id,
  },
  {
    :listname => "Kyle's Random Wish List",
    :listType_id => Listtype.find_by(listtype: "Other").id,
    :eventdate => "11/1/2014",
    :user_id => User.find_by(email: "test7@email.com").id,
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
  },
  {
    :shared_date => "03/09/2014",
    :list_id => List.find_by(listname: "Kyle's Random Wish List").id,
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
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Shirt",
    :quantity => 1,
    :comments => "I need new work clothes",
    :url => "http://bananarepublic.gap.com/browse/product.do?cid=56729&vid=1&pid=958408002",
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Kindle Fire",
    :quantity => 1,
    :comments => "I love tablets",
    :url => "http://www.amazon.com/kindle-fire-hdx-best-movie-tablet-8.9/dp/B00BHJRYYS/ref=sr_1_1?ie=UTF8&qid=1393814366&sr=8-1&keywords=kindle",
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Kellogg Tuition",
    :quantity => 1,
    :comments => "Kellogg is very expensive!",
    :url => "http://kellogg.northwestern.edu/",
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "The Signal and the Noise",
    :quantity => 3,
    :comments => "I am interested in statistical modeling",
    :url => "http://www.amazon.com/Signal-Noise-Many-Predictions-Fail/dp/159420411X/ref=sr_1_1?s=books&ie=UTF8&qid=1393814422&sr=1-1&keywords=signal+and+the+noise",
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Andy's Birthday List 2014").id
  },
  {
    :description => "Basketball",
    :quantity => 1,
    :comments => "I love to play basketball every day.",
    :url => "http://www.amazon.com/Spalding-NBA-Street-Basketball-Official/dp/B0009VELG4/ref=sr_1_1?ie=UTF8&qid=1393813830&sr=8-1&keywords=basketball",
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
  {
    :description => "Road Bike",
    :quantity => 1,
    :comments => "I love to ride",
    :url => "http://www.trekbikes.com/us/en/bikes/road/performance_race/madone_5_series/",
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
  {
    :description => "1984 the book",
    :quantity => 1,
    :comments => "I forgot to read this in high school!",
    :url => "http://www.amazon.com/gp/product/0451524934/ref=amb_link_397448882_1?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-5&pf_rd_r=1NT75RPVDBYYV1ZDBP90&pf_rd_t=101&pf_rd_p=1741872962&pf_rd_i=8192263011",
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
   {
    :description => "Amazon Prime",
    :quantity => 1,
    :comments => "I love fast shipping",
    :url => "http://www.amazon.com/Amazon-Prime-One-Year-Membership/dp/B00DBYBNEE",
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
   {
    :description => "Blue dress shirt",
    :quantity => 2,
    :comments => "I need more things to wear to the office",
    :url => "http://www1.macys.com/shop/product/alfani-spectrum-solid-slim-fit-long-sleeve-dress-shirt?ID=1285068&CategoryID=20635#fn=sp%3D1%26spc%3D846%26ruleId%3D78%26slotId%3D2",
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
   {
    :description => "Driver",
    :quantity => 1,
    :comments => "My dad keeps outdriving me by 20 yards...",
    :url => "http://www.dickssportinggoods.com/product/index.jsp?productId=30405146&cp=4406646.4413989.11399842.11025124",
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
   {
    :description => "More undershirts",
    :quantity => 3,
    :comments => "Need some more.",
    :url => "http://www.target.com/p/hanes-men-s-6pk-crew-neck-t-shirts-white/-/A-14450617#prodSlot=medium_1_1&term=undershirts",
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id
  },
   {
    :description => "Headphones",
    :quantity => 1,
    :comments => "I love to listen to music!",
    :url => "http://www.walmart.com/ip/Monster-NCredible-N-Tune-On-Ear-Headphones/22053755",
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Kyle's Random Wish List").id
  },
   {
    :description => "Desk Chair",
    :quantity => 1,
    :comments => "My current one is very uncomfortable",
    :url => "http://www.walmart.com/ip/Phoenix-Task-Chair-with-Arms-Multiple-Colors/14013709?povid=P1262-TJR-14013709",
    :request_type => RequestType.find_by(request_type_description: "Example").id,
    :list_id => List.find_by(listname: "Kyle's Random Wish List").id
  },
   {
    :description => "Swimsuit",
    :quantity => 2,
    :comments => "Need some more.",
    :url => "http://www.kohls.com/product/prd-1533044/nike-core-contender-colorblock-swim-trunks-men.jsp",
    :request_type => RequestType.find_by(request_type_description: "Exact Request").id,
    :list_id => List.find_by(listname: "Kyle's Random Wish List").id
  },
]

i.each do |item|
  it = Item.new
  it.description = item[:description]
  it.quantity_requested = item[:quantity]
  it.comments = item[:comments]
  it.url = item[:url]
  it.request_type_id = item[:request_type]
  it.list_id = item[:list_id]
  it.save
end




Purchase.destroy_all

p = [
  {
    :item_id => Item.find_by(:description => "More undershirts", :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id).id,
    :user_id => User.find_by(:email => "test@email.com").id,
    :date_purchased => "3/06/2014",
    :quantity_purchased => 1,
  },
  {
    :item_id => Item.find_by(:description => "Amazon Prime", :list_id => List.find_by(listname: "Jordan's Christmas List 2014").id).id,
    :user_id => User.find_by(:email => "test@email.com").id,
    :date_purchased => "3/06/2014",
    :quantity_purchased => 1,
  },
  {
    :item_id => Item.find_by(:description => "Swimsuit", :list_id => List.find_by(listname: "Kyle's Random Wish List").id).id,
    :user_id => User.find_by(:email => "test@email.com").id,
    :date_purchased => "3/06/2014",
    :quantity_purchased => 1,
  },

]


p.each do |pur|
  x = Purchase.new
  x.item_id = pur[:item_id]
  x.user_id = pur[:user_id]
  x.date_purchased = Date.strptime(pur[:date_purchased], "%m/%d/%Y")
  x.quantity_purchased = pur[:quantity_purchased]
  x.save
end







ConnectionType.destroy_all

# First populate the "primary" relationships
q = ["Husband","Wife","Brother","Sister","Friend","Mother","Father","Mother-in-law","Father-in-law","Daughter","Son","Son-in-law","Daughter-in-law","Brother-in-law","Sister-in-law","Grandson","Granddaughter","Grandmother", "Grandfather", "Aunt", "Uncle", "Niece", "Nephew"].sort
q.push("Other")
q.each do |r|
    p = ConnectionType.new
    p.connection_description = r
    p.inverse_male_connection_id = 99999
    p.inverse_female_connection_id = 99999
    p.inverse_unknown_connection_id = 99999
    p.save
end

# Now go back and figure out the inverse (for smart population)
ir = [
  {
    :connection_description => "Husband",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Husband").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Wife").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Wife").id,
  },
  {
    :connection_description => "Wife",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Husband").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Wife").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Husband").id,
  },
  {
    :connection_description => "Brother",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Brother").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Sister").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Brother").id,
  },
  {
    :connection_description => "Sister",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Brother").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Sister").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Brother").id,
  },
  {
    :connection_description => "Friend",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Friend").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Friend").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Friend").id,
  },
  {
    :connection_description => "Mother",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Son").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Daughter").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Son").id,
  },
  {
    :connection_description => "Father",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Son").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Daughter").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Son").id,
  },
  {
    :connection_description => "Mother-in-law",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Son-in-law").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Daughter-in-law").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Son-in-law").id,
  },
  {
    :connection_description => "Father-in-law",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Son-in-law").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Daughter-in-law").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Son-in-law").id,
  },
  {
    :connection_description => "Daughter",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Father").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Mother").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Father").id,
  },
  {
    :connection_description => "Son",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Father").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Mother").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Father").id,
  },
  {
    :connection_description => "Son-in-law",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Father-in-law").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Mother-in-law").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Father-in-law").id,
  },
  {
    :connection_description => "Daughter-in-law",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Father-in-law").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Mother-in-law").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Father-in-law").id,
  },
  {
    :connection_description => "Brother-in-law",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Brother-in-law").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Sister-in-law").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Brother-in-law").id,
  },
  {
    :connection_description => "Sister-in-law",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Brother-in-law").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Sister-in-law").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Brother-in-law").id,
  },
  {
    :connection_description => "Grandson",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Grandfather").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Grandmother").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Grandfather").id,
  },
  {
    :connection_description => "Granddaughter",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Grandfather").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Grandmother").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Grandfather").id,
  },
  {
    :connection_description => "Grandmother",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Grandson").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Granddaughter").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Grandson").id,
  },
  {
    :connection_description => "Grandfather",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Grandson").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Granddaughter").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Grandson").id,
  },
  {
    :connection_description => "Aunt",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Nephew").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Niece").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Nephew").id,
  },
  {
    :connection_description => "Uncle",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Nephew").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Niece").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Nephew").id,
  },
  {
    :connection_description => "Niece",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Uncle").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Aunt").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Uncle").id,
  },
  {
    :connection_description => "Nephew",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Uncle").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Aunt").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Uncle").id,
  },
  {
    :connection_description => "Other",
    :inverse_male_connection_id => ConnectionType.find_by(:connection_description => "Other").id,
    :inverse_female_connection_id => ConnectionType.find_by(:connection_description => "Other").id,
    :inverse_unknown_connection_id => ConnectionType.find_by(:connection_description => "Other").id,
  },
]

ir.each do |r|
    p = ConnectionType.find_by(:connection_description => r[:connection_description])
    p.inverse_male_connection_id = r[:inverse_male_connection_id]
    p.inverse_female_connection_id = r[:inverse_female_connection_id]
    p.inverse_unknown_connection_id = r[:inverse_unknown_connection_id]
    p.save
end



Connection.destroy_all

c = [
  # Primary Relationships
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
    :user_id => User.find_by(email: "test@email.com").id,
    :connected_user_id => User.find_by(email: "test7@email.com").id,
    :connection_type_id => ConnectionType.find_by(connection_description: "Friend").id,
  },

  # Inverse Relationships
  {
    :user_id => User.find_by(email: "test2@email.com").id,
    :connected_user_id => User.find_by(email: "test@email.com").id,
    :connection_type_id => ConnectionType.find_by(connection_description: "Friend").id,
  },
  {
    :user_id => User.find_by(email: "test3@email.com").id,
    :connected_user_id => User.find_by(email: "test@email.com").id,
    :connection_type_id => ConnectionType.find_by(connection_description: "Brother-in-law").id,
  },
  {
    :user_id => User.find_by(email: "test7@email.com").id,
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
    :connection_type_id => ConnectionType.find_by(connection_description: "Uncle").id,
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







