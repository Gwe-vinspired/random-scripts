POSTCODES = ["EC1A","EC1M","EC1N","EC1P","EC1R","EC1V","EC1Y","EC2A","EC2M","EC2N","EC2P","EC2R","EC2V","EC2Y","EC3A","EC3M","EC3N","EC3P","EC3R","EC3V","EC4A","EC4M","EC4N","EC4P","EC4R","EC4V","EC4Y","WC1A","WC1B","WC1E","WC1H","WC1N","WC1R","WC1V","WC1X","WC2A","WC2B","WC2E","WC2H","WC2N","WC2R","E1","E2","E3","E4","E5","E6","E7","E8","E9","E10","E11","E12","E13","E14","E15","E16","E17","E18","E20","N1","N2","N3","N4","N5","N6","N7","N8","N9","N10","N11","N12","N13","N14","N15","N16","N17","N18","N19","N20","N21","N22","NW1","NW2","NW3","NW4","NW5","NW6","NW7","NW8","NW9","NW10","NW11","SE1","SE2","SE3","SE4","SE5","SE6","SE7","SE8","SE9","SE10","SE11","SE12","SE13","SE14","SE15","SE16","SE17","SE18","SE19","SE20","SE21","SE22","SE23","SE24","SE25","SE26","SE27","SE28","SW1","SW2","SW3","SW4","SW5","SW6","SW7","SW8","SW9","SW10","SW11","SW12","SW13","SW14","SW15","SW16","SW17","SW18","SW19","SW20","W1","W2","W3","W4","W5","W6","W7","W8","W9","W10","W11","W12","W13","W14"]
LONDON_POSTCODES = ["BR1","BR2","BR3","BR4","BR5","BR6","BR7","CR0","CR1","CR2","CR4","CR5","CR8","DA1","DA14","DA15","DA16","DA17","DA5","DA6","DA8","E1","E10","E11","E12","E13","E14","E15","E16","E17","E18","E2","E3","E4","E5","E6","E7","E8","E9","EC1","EC2","EC3","EC3R","EC4","EN1","EN2","EN3","EN4","EN5","HA0","HA1","HA2","HA3","HA4","HA5","HA6","HA7","HA8","HA9","IG1","IG11","IG2","IG3","IG6","IG8","KT1","KT2","KT3","KT4","KT6","KT9","N1","N10","N11","N12","N13","N14","N15","N16","N17","N18","N19","N2","N20","N21","N22","N3","N4","N5","N6","N7","N8","N9","NW1","NW10","NW11","NW2","NW3","NW4","NW5","NW6","NW7","NW8","NW9","RM1","RM10","RM12","RM13","RM14","RM2","RM3","RM4","RM5","RM6","RM7","RM8","RM9","SE1","SE10","SE11","SE12","SE13","SE14","SE15","SE16","SE17","SE18","SE19","SE2","SE20","SE21","SE22","SE23","SE24","SE25","SE26","SE27","SE28","SE3","SE4","SE5","SE6","SE7","SE8","SE9","SM2","SM3","SM4","SM5","SM6","SM7","SW1","SW10","SW11","SW12","SW13","SW14","SW15","SW16","SW17","SW18","SW19","SW1A","SW2","SW20","SW3","SW4","SW5","SW6","SW7","SW8","SW9","TN14","TN16","TW1","TW10","TW11","TW12","TW13","TW14","TW3","TW4","TW5","TW7","TW8","TW9","UB1","UB10","UB2","UB3","UB4","UB5","UB6","UB7","UB8","UB9","W1","W10","W11","W12","W13","W14","W1M","W2","W3","W4","W5","W6","W7","W8","W9","WC1","WC2"]
STARTDATE = "2016-04-01 00:00:00"
ENDDATE = "2017-03-30 23:59:59"
# LONDON_POSTCODES is a larger area, all the postcodes for "greater london" (includes Croydon, Ruislip etc)

count = 0
year_users = User.where("((current_login_at >= :start_date AND current_login_at <= :end_date)OR(last_login_at >= :start_date AND last_login_at <= :end_date)OR(created_at >= :start_date AND created_at <= :end_date))AND admin != 1 AND organization_id IS NULL",{start_date: STARTDATE, end_date: ENDDATE})
year_users.each do |u|    
 if u.postcode && (LONDON_POSTCODES.include?(u.postcode.split(" ")[0]) || LONDON_POSTCODES.include?(u.postcode[0..2])|| LONDON_POSTCODES.include?(u.postcode[0..3]))
    p "VALID" + u.postcode
    count +=1
  else
    if u.postcode
      p "NOT VALID" + u.postcode
    end  
  end  
end
p count