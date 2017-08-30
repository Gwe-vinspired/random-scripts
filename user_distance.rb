# Get a lists of users / user_events and the distance between them, 
# only getting London Postcodes and users wth logged hours

# Run through a rails console:
#   $: cd ~/vinspired/vapi
#   $: rails c
#   pry> load '../script/user_distance.rb'
#   pry> user_distance

# Output:
#   + writes to a csv file: ~/vinspired/vapi/user_applications_distances.csv
#   + outputs a hash of {#user_postcode => [distances to aplications]}
#   + outputs a hash of {#user_postcode => #average_distance_to_application}

# Warning:
#   This is very greedy in geocoding requests, you'll hit google api request limit very quickly.
#   I created a Geocoder config to cache the calls with redis and use a bing api key (at the bottom of file)

require "csv"


LONDON_POSTCODES = ["EC1A","EC1M","EC1N","EC1P","EC1R","EC1V","EC1Y","EC2A","EC2M","EC2N","EC2P","EC2R","EC2V","EC2Y","EC3A","EC3M","EC3N","EC3P","EC3R","EC3V","EC4A","EC4M","EC4N","EC4P","EC4R","EC4V","EC4Y","WC1A","WC1B","WC1E","WC1H","WC1N","WC1R","WC1V","WC1X","WC2A","WC2B","WC2E","WC2H","WC2N","WC2R","E1","E2","E3","E4","E5","E6","E7","E8","E9","E10","E11","E12","E13","E14","E15","E16","E17","E18","E20","N1","N2","N3","N4","N5","N6","N7","N8","N9","N10","N11","N12","N13","N14","N15","N16","N17","N18","N19","N20","N21","N22","NW1","NW2","NW3","NW4","NW5","NW6","NW7","NW8","NW9","NW10","NW11","SE1","SE2","SE3","SE4","SE5","SE6","SE7","SE8","SE9","SE10","SE11","SE12","SE13","SE14","SE15","SE16","SE17","SE18","SE19","SE20","SE21","SE22","SE23","SE24","SE25","SE26","SE27","SE28","SW1","SW2","SW3","SW4","SW5","SW6","SW7","SW8","SW9","SW10","SW11","SW12","SW13","SW14","SW15","SW16","SW17","SW18","SW19","SW20","W1","W2","W3","W4","W5","W6","W7","W8","W9","W10","W11","W12","W13","W14"]

@avg = {}
@avg_bp = {}
def user_distance
  CSV.open("user_applications_distances.csv", "a",
    :write_headers=> true,
    :headers => ["User Id", "User Postcode", "Role Postcode", "Disctance (in miles)", "Has logged hours", "User Address", "Role Address"]
  ) do |csv|
    User.all.each_with_index do |u, index|
      p index
      if u.postcode && u.postcode.split(" ")[0]
        if (LONDON_POSTCODES.include? u.postcode.split(" ")[0].upcase) && (u.hours_recorded > 0)
          # p "true -- #{u.user_events.count}"
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
                    make_short_pc_array(u.postcode, distance)
                    csv << ["#{u.id}", "#{u.postcode}","#{event.postcode}", "#{distance}", "#{u.hours_recorded}", "#{user_location.first.address}", "#{location.first.address}"]
                  end
                end            
              end 
            end 
          end    
        end  
      end  
    end
    p calc_averages
  end  
end

def make_short_pc_array(postcode, distance)
  short_pc = postcode.split(" ")[0]
  if @avg.key? short_pc
    @avg[short_pc] << distance
  else  
    @avg[short_pc] = [distance]
  end  
end

def calc_averages
  @avg_bp = @avg
  p @avg_bp
  @avg.each do |k,v|
    @avg[k] = (v.sum / v.size.to_f)
  end  
  return @avg
end 



# require 'redis'

# REDIS = Redis.new(host: "localhost", port: 6379)

# Geocoder.configure(
#   lookup: :bing,
#   api_key: "XXX",
#   cache: REDIS,
#   units: :mi,
#   always_raise: [
#     Geocoder::OverQueryLimitError,
#     Geocoder::RequestDenied,
#     Geocoder::InvalidRequest,
#     Geocoder::InvalidApiKey
#   ]
# )