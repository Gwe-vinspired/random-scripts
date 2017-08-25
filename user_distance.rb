require "csv"


def user_distance
  CSV.open("user_applications_distances.csv", "a",
    :write_headers=> true,
    :headers => ["User Id", "User Postcode", "Role Postcode", "Disctance (in miles)", "Has logged hours", "User Address", "Role Address"]
  ) do |csv|
    User.all.limit(250).each_with_index do |u, index|
      p index
      applications = u.user_events
      if u.postcode
        user_location = Geocoder.search(u.postcode)

        if applications.length > 0
          applications.each do |a|
            event = a.event
            if event.postcode
              location = Geocoder.search(event.postcode)
              if user_location.first && location.first
                distance = Geocoder::Calculations.distance_between(user_location.first.coordinates, location.first.coordinates)
                csv << ["#{u.id}", "#{u.postcode}","#{event.postcode}", "#{distance}", "#{u.hours_recorded}", "#{user_location.first.formatted_address}", "#{location.first.formatted_address}"]
              end
            end            
          end 
        end 
      end    
    end
  end  
end