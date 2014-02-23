
State.destroy_all

["AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"].each do |state_abbrev|
    s = State.new
    s.state = state_abbrev
    s.save
end

User.destroy_all

  a = User.new
  a.firstname = "Andy"
  a.lastname = "Crewson"
  a.birthdate = "10/10/1986"
  a.address = "1106 Davis St Apt 3"
  a.city = "Evanston"
  a.state_id = State.where(state: "IL")
  a.zip = 60201
  a.email = "acrewson@gmail.com"
  a.password = "password"
  a.save



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

l = List.new
l.listname = "Andy's Birthday List 2014"
l.eventdate = "10/10/2014"
l.save

l = List.new
l.listname = "Andy's Christmas List 2014"
l.eventdate = "10/10/2014"
l.save

l = List.new
l.listname = "Andy's Random List!"
l.eventdate = "10/10/2014"
l.save



