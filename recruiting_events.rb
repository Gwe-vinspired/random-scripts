CSV.open("underway.csv", "wb") do |csv|
  csv << Event.attribute_names
  Event.underway.where("type IS NULL").each_with_index do |event, index|
    p index
    csv << event.attributes.values
  end
end