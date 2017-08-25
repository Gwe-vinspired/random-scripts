Event.all.each do |e|
  opp = Opportunity.find_by_id(e.opportunity_id)
  if opp
    e.organization_id = opp.organization_id
    e.save
  end  
end