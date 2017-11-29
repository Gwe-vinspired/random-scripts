# array = []
LONDON_POSTCODES = ["BR1","BR2","BR3","BR4","BR5","BR6","BR7","CR0","CR1","CR2","CR4","CR5","CR8","DA1","DA14","DA15","DA16","DA17","DA5","DA6","DA8","E1","E10","E11","E12","E13","E14","E15","E16","E17","E18","E2","E3","E4","E5","E6","E7","E8","E9","EC1","EC2","EC3","EC3R","EC4","EN1","EN2","EN3","EN4","EN5","HA0","HA1","HA2","HA3","HA4","HA5","HA6","HA7","HA8","HA9","IG1","IG11","IG2","IG3","IG6","IG8","KT1","KT2","KT3","KT4","KT6","KT9","N1","N10","N11","N12","N13","N14","N15","N16","N17","N18","N19","N2","N20","N21","N22","N3","N4","N5","N6","N7","N8","N9","NW1","NW10","NW11","NW2","NW3","NW4","NW5","NW6","NW7","NW8","NW9","RM1","RM10","RM12","RM13","RM14","RM2","RM3","RM4","RM5","RM6","RM7","RM8","RM9","SE1","SE10","SE11","SE12","SE13","SE14","SE15","SE16","SE17","SE18","SE19","SE2","SE20","SE21","SE22","SE23","SE24","SE25","SE26","SE27","SE28","SE3","SE4","SE5","SE6","SE7","SE8","SE9","SM2","SM3","SM4","SM5","SM6","SM7","SW1","SW10","SW11","SW12","SW13","SW14","SW15","SW16","SW17","SW18","SW19","SW1A","SW2","SW20","SW3","SW4","SW5","SW6","SW7","SW8","SW9","TN14","TN16","TW1","TW10","TW11","TW12","TW13","TW14","TW3","TW4","TW5","TW7","TW8","TW9","UB1","UB10","UB2","UB3","UB4","UB5","UB6","UB7","UB8","UB9","W1","W10","W11","W12","W13","W14","W1M","W2","W3","W4","W5","W6","W7","W8","W9","WC1","WC2"]

# NE_POSTCODES = ["DH1","DH2","DH3","DH4","DH5","DH6","DH7","DH8","DH9","DH97","DH98","DH99","DL1","DL2","DL3","DL4","DL5","DL6","DL7","DL8","DL9","DL10","DL11","DL12","DL13","DL14","DL15","DL16","DL17","DL98","NE1","NE2","NE3","NE4","NE5","NE6","NE7","NE8","NE9","NE10","NE11","NE12","NE13","NE15","NE16","NE17","NE18","NE19","NE20","NE21","NE22","NE23","NE24","NE25","NE26","NE27","NE28","NE29","NE30","NE31","NE32","NE33","NE34","NE35","NE36","NE37","NE38","NE39","NE40","NE41","NE42","NE43","NE44","NE45","NE46","NE47","NE48","NE49","NE61","NE62","NE63","NE64","NE65","NE66","NE66","NE67","NE68","NE69","NE70","NE71","NE82","NE83","NE85","NE88","NE92","NE98","NE99","SR1","SR2","SR3","SR4","SR5","SR6","SR7","SR8","SR9","TD1","TD2","TD3","TD4","TD5","TD6","TD7","TD8","TD9","TD10","TD11","TD12","TD13","TD14","TD15","TS1","TS2","TS3","TS4","TS5","TS6","TS7","TS8","TS9","TS10","TS11","TS12","TS13","TS14","TS15","TS16","TS17","TS18","TS19","TS20","TS21","TS22","TS23","TS24","TS25","TS26","TS27","TS28","TS29","DL1","DL2","DL3","DL4","DL5","DL6","DL7","DL8","DL9","DL10","DL11","DL12","DL13","DL14","DL15","DL16","DL16","DL17","DL98"]


# Organization.all.each_with_index do |o,index|
#   unless o.lat.nil? || o.long.nil?
#     if o.postcode && (LONDON_POSTCODES.include?(o.postcode.split(" ")[0]) || LONDON_POSTCODES.include?(o.postcode[0..2])|| LONDON_POSTCODES.include?(o.postcode[0..3]))
#       array << [o.lat,o.long]
#     end  
#   end  
# end
# p array



# -----------------


# Event.recruiting.each_with_index do |event,index|
#   unless event.lat.nil? || event.long.nil?
#     if event.postcode && (NE_POSTCODES.include?(event.postcode.split(" ")[0]) || NE_POSTCODES.include?(event.postcode[0..2])|| NE_POSTCODES.include?(event.postcode[0..3]))
#       array << [event.lat,event.long]
#     end  
#   end  
# end
# p array



# -----------------


Role.all.where("lat IS NOT NULL").each_with_index do |event,index|
  unless event.lat.nil? || event.long.nil?
    # if event.postcode && (LONDON_POSTCODES.include?(event.postcode.split(" ")[0]) || LONDON_POSTCODES.include?(event.postcode[0..2])|| LONDON_POSTCODES.include?(event.postcode[0..3]))
      array << [event.lat,event.long]
    # end  
  end  
end
p array