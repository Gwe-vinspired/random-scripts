e = Event.find(260176) 
r = Role.find(e.id)
opp = e.opportunity
if opp.identity.exists?
  p e.id
  r.identity = opp.identity
else
  p "No Identity for #{e.id}"
end  
r.save(validate: false)
