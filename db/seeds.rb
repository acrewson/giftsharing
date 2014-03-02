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


