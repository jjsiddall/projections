class Player < ActiveRecord::Base
  attr_accessible :attempts, :completions, :fpoints, :fumble_recoveries, :fumble_lost, :source, :interceptions, :kicking_attempts_1_to_39, :kicking_attempts_40_to_49, :kicking_attempts_XP, :kicking_attempts_over_50, :kicking_attempts_total, :kicking_completions_1_to_39, :kicking_completions_40_to_49, :kicking_completions_XP, :kicking_completions_over_50, :kicking_completions_total, :name, :pass_tds, :pass_yards, :two_pt_conversions, :picture_url, :points_against, :position, :receiving_tds, :receiving_yards, :receptions, :rush_tds, :rush_yards, :rushes, :sacks, :stat_year, :targets, :team, :yards_against, :fumble_forced, :safety

  	def nflDataPull(number_of_players = 100)
  		(1..number_of_players).step(25) do |i|			
			#QBs
			url = "http://fantasy.nfl.com/research/projections?position=1&statType=seasonProjectedStats&offset="+ i.to_s				
			nflPlayers(url)				
			#RBs
			url = "http://fantasy.nfl.com/research/projections?position=2&statType=seasonProjectedStats&offset="+ i.to_s				
			nflPlayers(url)				
			#WR
			url = "http://fantasy.nfl.com/research/projections?position=3&statType=seasonProjectedStats&offset="+ i.to_s				
			nflPlayers(url)			
			#TE
			url = "http://fantasy.nfl.com/research/projections?position=4&statType=seasonProjectedStats&offset="+ i.to_s				
			nflPlayers(url)			
		end  			
  	end
  	def nflPlayers(url)
  		doc = getWebsiteAsNokogiriDoc(url)
  		doc = doc.css(".odd") + doc.css(".even")
  		doc.each do |nflPlayer|
  			player = Player.new

		 	player.source = "NFL"
		 	player.stat_year = 2014

  		 	player.name = nflPlayer.css(".playerName").text
  			player.team = nflPlayer.css("em").text.split(" - ")[1]
   		 	player.position = nflPlayer.css("em").text.split(" - ")[0]

		    player.pass_yards = nflPlayer.css(".statId-5").text
		    player.pass_tds = nflPlayer.css(".statId-6").text
		    player.interceptions = nflPlayer.css(".statId-7").text

		    player.rush_yards = nflPlayer.css(".statId-14").text
		    player.rush_tds = nflPlayer.css(".statId-15").text

		    player.receiving_yards = nflPlayer.css(".statId-21").text
		    player.receiving_tds = nflPlayer.css(".statId-22").text

		    player.forced_fumble = nflPlayer.css(".statId-29").text
		    player.two_pt_conversions = nflPlayer.css(".statId-32").text

		    player.fumble_lost = nflPlayer.css(".statId-30").text
			player.fpoints = nflPlayer.css("td.last").text

	  		player.save
  		end
  	end
  	# def nflRunningbacks(url)
  	# 	doc = getWebsiteAsNokogiriDoc(url)
  	# 	doc = doc.css(".odd") + doc.css(".even")
  	# 	doc.each do |nflPlayer|
  	# 		player = Player.new

   # 		 	player.position = "RB"
		 # 	player.source = "NFL"
		 # 	player.stat_year = 2014

  	# 	 	player.name = nflPlayer.css(".playerName").text
  	# 		player.team = nflPlayer.css("em").text.split(" - ")[1]

		 #    player.rush_yards = nflPlayer.css(".statId-14").text
		 #    player.rush_tds = nflPlayer.css(".statId-15").text



		 #    player.two_pt_conversions = nflPlayer.css(".statId-32").text
		 #    player.fumble_lost = nflPlayer.css(".statId-30").text
		 #    player.fpoints = nflPlayer.css("td.last").text

	  # 		player.save
  	# 	end
  	# end
  	# def nflWidereceivers(url)
  	# 	doc = getWebsiteAsNokogiriDoc(url)
  	# 	doc = doc.css(".odd") + doc.css(".even")
  	# 	doc.each do |nflPlayer|
  	# 		player = Player.new

   # 		 	player.position = "WR"
		 # 	player.source = "NFL"
		 # 	player.stat_year = 2014

  	# 	 	player.name = nflPlayer.css(".playerName").text
  	# 		player.team = nflPlayer.css("em").text.split(" - ")[1]

		 #    player.rush_yards = nflPlayer.css(".statId-14").text
		 #    player.rush_tds = nflPlayer.css(".statId-15").text

		 #    player.receiving_yards = nflPlayer.css(".statId-21").text
		 #    player.receiving_tds = nflPlayer.css(".statId-22").text

		 #    player.two_pt_conversions = nflPlayer.css(".statId-32").text
		 #    player.fumble_lost = nflPlayer.css(".statId-30").text
		 #    player.fpoints = nflPlayer.css("td.last").text

	  # 		player.save
  	# 	end
  	# end

  	def cbsDataPull
		##### CBS Average
  		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/QB/season/avg/standard?&print_rows=9999"
  		cbsQuarterbacks(url)
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/RB/season/avg/standard?&print_rows=9999"
  		cbsRunningBacks(url)
  		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/WR/season/avg/standard?&print_rows=9999"
  		cbsWideReceivers(url, "WR")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/TE/season/avg/standard?&print_rows=9999"
  		cbsWideReceivers(url, "TE")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/K/season/avg/standard"
  		cbsKickers(url)
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/DST/season/avg/standard"
  		cbsDefenses(url)

		##### Jamey Eisenberg
  		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/QB/season/jamey_eisenberg/standard?&print_rows=9999"
  		cbsQuarterbacks(url, "Jamey Eisenberg")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/RB/season/jamey_eisenberg/standard?&print_rows=9999"
  		cbsRunningBacks(url, "Jamey Eisenberg")
  		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/WR/season/jamey_eisenberg/standard?&print_rows=9999"
  		cbsWideReceivers(url, "WR", "Jamey Eisenberg")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/TE/season/jamey_eisenberg/standard?&print_rows=9999"
  		cbsWideReceivers(url, "TE", "Jamey Eisenberg")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/K/season/jamey_eisenberg/standard"
  		cbsKickers(url, "Jamey Eisenberg")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/DST/season/jamey_eisenberg/standard"
  		cbsDefenses(url, "Jamey Eisenberg")

		##### Dave Richard
  		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/QB/season/dave_richard/standard?&print_rows=9999"
  		cbsQuarterbacks(url, "Dave Richard")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/RB/season/dave_richard/standard?&print_rows=9999"
  		cbsRunningBacks(url, "Dave Richard")
  		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/WR/season/dave_richard/standard?&print_rows=9999"
  		cbsWideReceivers(url, "WR", "Dave Richard")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/TE/season/dave_richard/standard?&print_rows=9999"
  		cbsWideReceivers(url, "TE", "Dave Richard")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/K/season/dave_richard/standard"
  		cbsKickers(url, "Dave Richard")
   		url = "http://fantasynews.cbssports.com/fantasyfootball/stats/weeklyprojections/DST/season/dave_richard/standard"
  		cbsDefenses(url, "Dave Richard")
  	end
  	def cbsQuarterbacks(url, source = "CBS")
  		doc = getWebsiteAsNokogiriDoc(url)
  		doc = doc.css(".row1") + doc.css(".row2")
  		doc.shift
  		doc.each do |cbsPlayer|
  			player = Player.new
  			playerStats = cbsPlayer.css("td")
  		 	player.name = playerStats[0].text.split(/,/)[0].strip
  			player.team = playerStats[0].text.split(/,/)[1].to_s.strip
  		 	player.position = "QB"
		 	player.source = source
		 	player.stat_year = 2014

		    player.attempts = playerStats[1].text
		    player.completions = playerStats[2].text
		    player.pass_yards = playerStats[3].text
		    player.pass_tds = playerStats[4].text
		    player.interceptions = playerStats[5].text

		    player.rushes = playerStats[8].text
		    player.rush_yards = playerStats[9].text
		    player.rush_tds = playerStats[11].text
		    player.fumble_lost = playerStats[12].text
			player.fpoints = playerStats[13].text

	  		player.save

  		end
  	end
  	def cbsRunningBacks(url, source = "CBS")
  		doc = getWebsiteAsNokogiriDoc(url)
  		doc = doc.css(".row1") + doc.css(".row2")
  		doc.shift
  		players = Array.new
  		doc.each do |cbsPlayer|
  			playerStats = cbsPlayer.css("td")
  		 	player.name = playerStats[0].text.split(/,/)[0].strip
  			player.team = playerStats[0].text.split(/,/)[1].to_s.strip
  		 	player.position = "RB"
		 	player.source = source
		 	player.stat_year = 2014

		    player.rushes = playerStats[1].text
		    player.rush_yards = playerStats[2].text
		    player.rush_tds = playerStats[4].text
		    player.receptions = playerStats[5].text
		    player.receiving_yards = playerStats[6].text
		    player.receiving_tds = playerStats[8].text
		    player.fumble_lost = playerStats[9].text
		    player.fpoints = playerStats[10].text

	  		player.save
  		end
  	end
  	def cbsWideReceivers(url, position, source = "CBS")
  		doc = getWebsiteAsNokogiriDoc(url)
  		doc = doc.css(".row1") + doc.css(".row2")
  		doc.shift
  		doc.each do |cbsPlayer|
  			player = Player.new
  			playerStats = cbsPlayer.css("td")
  		 	player.name = playerStats[0].text.split(/,/)[0].strip
  			player.team = playerStats[0].text.split(/,/)[1].to_s.strip
  		 	player.position = position
		 	player.source = source
		 	player.stat_year = 2014

		    player.receptions = playerStats[1].text
		    player.receiving_yards = playerStats[2].text
		    player.receiving_tds = playerStats[4].text
		    player.fumble_lost = playerStats[5].text
			player.fpoints = playerStats[6].text

	  		player.save

  		end
  	end
  	def cbsDefenses(url, source = "CBS")
  		doc = getWebsiteAsNokogiriDoc(url)
  		doc = doc.css(".row1") + doc.css(".row2")
  		doc.each do |cbsPlayer|
  			player = Player.new
  			playerStats = cbsPlayer.css("td")
  		 	player.name = playerStats[0].text.split(/,/)[0].strip
  			player.team = playerStats[0].text.split(/,/)[1].to_s.strip

		 	player.source = source
		 	player.stat_year = 2014

  		 	player.position = "D/ST"
		    player.interceptions = playerStats[1].text
		    player.fumble_recoveries = playerStats[2].text
		    player.forced_fumble = playerStats[3].text
		    player.sacks = playerStats[4].text
		    player.rush_tds = playerStats[5].text
		    player.safety = playerStats[6].text
		    player.points_against = playerStats[7].text
		    player.yards_against = playerStats[8].text
		    player.fpoints = playerStats[9].text

	  		player.save
  		end
  	end 
  	def cbsKickers(url, source = "CBS")
  		doc = getWebsiteAsNokogiriDoc(url)
  		doc = doc.css(".row1") + doc.css(".row2")
  		players = Array.new
  		doc.each do |cbsPlayer|
  			player = Player.new
  			playerStats = cbsPlayer.css("td")
  		 	player.name = playerStats[0].text.split(/,/)[0].strip
  			player.team = playerStats[0].text.split(/,/)[1].to_s.strip

		 	player.source = source
		 	player.stat_year = 2014

  		 	player.position = "K"
		    player.kicking_completions_total = playerStats[1].text
		    player.kicking_attempts_total = playerStats[2].text
		    player.kicking_completions_XP = playerStats[3].text
		    player.fpoints = playerStats[4].text

	  		player.save
  		end
  	end  	

	def espnDataPull
		getESPNPlayers("Quarterbacks")
		getESPNPlayers("Running Backs")
		getESPNPlayers("Wide Receivers")
		getESPNPlayers("Tight Ends")
		getESPNPlayers("Defenses", 30)
		getESPNPlayers("Kickers", 65)
	end
	def getESPNPlayers(player_type, number_of_players = 80)
		(0..number_of_players).step(15) do |i|			
			if player_type == "Quarterbacks"
				puts "*******"
				puts "Doing QBs"
				url = 'http://games.espn.go.com/ffl/tools/projections?display=alt&slotCategoryId=0&startIndex='+ i.to_s
				espnQuarterbacks(url)			
			elsif player_type == "Running Backs"
				puts "*******"
				puts "Doing RBs"			
				url = 'http://games.espn.go.com/ffl/tools/projections?display=alt&slotCategoryId=2&startIndex='+ i.to_s
				espnRunningBacks(url)
			elsif player_type == "Wide Receivers"
				puts "*******"
				puts "Doing WRs"			
				url = 'http://games.espn.go.com/ffl/tools/projections?display=alt&slotCategoryId=4&startIndex='+ i.to_s
				espnWideReceivers(url)
			elsif player_type == "Tight Ends"
				puts "*******"
				puts "Doing TEs"			
				url = 'http://games.espn.go.com/ffl/tools/projections?display=alt&slotCategoryId=6&startIndex='+ i.to_s
				espnWideReceivers(url)
			elsif player_type == "Defenses"
				puts "*******"
				puts "Doing Defenses"			
				url = 'http://games.espn.go.com/ffl/tools/projections?display=alt&slotCategoryId=16&startIndex=' + i.to_s
				espnDefenses(url)
			elsif player_type == "Kickers"
				puts "*******"
				puts "Doing Kickers"			
				url = 'http://games.espn.go.com/ffl/tools/projections?display=alt&slotCategoryId=17&startIndex=' + i.to_s
				espnKickers(url)
			end
		end
	end
	def espnQuarterbacks(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# interate through webpage
		doc.css(".tableBody").each do |espnPlayer|

			# create new (blank) player
			player = Player.new

		#### Player NAME
			# add data from page to new (blank player)
			player.name = espnPlayer.css(".tableSubHead td:nth-child(1)").text#.split(/./)[1].strip
			if player.name != ""

				#parse player name to get team and position
				player.team = player.name.split(/,/)[1].strip.split(" ")[0]
				player.position = player.name.split(/,/)[1].strip.split(" ")[1]
				player.name = parseESPNPlayerName(player.name)
				player.picture_url = espnPlayer.css("img:nth-child(1)").attribute('src').to_s.split("&")[0]

				#### Year = 2013
			 	player.source = "ESPN"
			 	player.stat_year = 2013
			
			    player.completions = espnPlayer.css(".playertableStat")[8].text.split("/")[0]
			    player.attempts = espnPlayer.css(".playertableStat")[8].text.split("/")[1]
			    player.pass_yards = espnPlayer.css(".playertableStat")[9].text
			    player.pass_tds = espnPlayer.css(".playertableStat")[10].text
			    player.interceptions = espnPlayer.css(".playertableStat")[11].text
				player.rushes = espnPlayer.css(".playertableStat")[12].text
				player.rush_yards = espnPlayer.css(".playertableStat")[13].text
			    player.rush_tds = espnPlayer.css(".playertableStat")[14].text
    			player.fpoints = espnPlayer.css(".playertableStat")[15].text

				player.save

				#### Year = 2014
				player2 = Player.new
				player2.team = player.team
				player2.position = player.position
				player2.name = player.name
				player2.picture_url = player.picture_url

			  	player2.source = "ESPN"
			  	player2.stat_year = 2014
			    player2.completions = espnPlayer.css(".playertableStat")[16].text.split("/")[0]
			    player2.attempts = espnPlayer.css(".playertableStat")[16].text.split("/")[1]
			    player2.pass_yards = espnPlayer.css(".playertableStat")[17].text
			    player2.pass_tds = espnPlayer.css(".playertableStat")[18].text
			    player2.interceptions = espnPlayer.css(".playertableStat")[19].text
				player2.rushes = espnPlayer.css(".playertableStat")[20].text
				player2.rush_yards = espnPlayer.css(".playertableStat")[21].text
			    player2.rush_tds = espnPlayer.css(".playertableStat")[22].text
    			player2.fpoints = espnPlayer.css(".playertableStat")[23].text

				player2.save
		    end
		end 
	end	
	def espnRunningBacks(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# interate through webpage
		doc.css(".tableBody").each do |espnPlayer|

			# create new (blank) player
			player = Player.new

		#### Player NAME
			# add data from page to new (blank player)
			player.name = espnPlayer.css(".tableSubHead td:nth-child(1)").text#.split(/./)[1].strip
			if player.name != ""

				#parse player name to get team and position
				player.team = player.name.split(/,/)[1].strip.split(" ")[0]
				player.position = player.name.split(/,/)[1].strip.split(" ")[1]
				player.name = parseESPNPlayerName(player.name)
				player.picture_url = espnPlayer.css("img:nth-child(1)").attribute('src').to_s.split("&")[0]
	
			# 	#### Year = 2013
			 	player.source = "ESPN"
			 	player.stat_year = 2013
				player.rushes = espnPlayer.css(".playertableStat")[8].text
				player.rush_yards = espnPlayer.css(".playertableStat")[9].text
			    player.rush_tds = espnPlayer.css(".playertableStat")[11].text
			    player.receptions = espnPlayer.css(".playertableStat")[12].text
			    player.receiving_yards = espnPlayer.css(".playertableStat")[13].text
    			player.receiving_tds = espnPlayer.css(".playertableStat")[14].text
    			player.fpoints = espnPlayer.css(".playertableStat")[15].text

				player.save

			# 	#### Year = 2014
				player2 = Player.new
				player2.team = player.team
				player2.position = player.position
				player2.name = player.name
				player2.picture_url = player.picture_url

			 	player2.source = "ESPN"
			 	player2.stat_year = 2014
				player2.rushes = espnPlayer.css(".playertableStat")[16].text
				player2.rush_yards = espnPlayer.css(".playertableStat")[17].text
			    player2.rush_tds = espnPlayer.css(".playertableStat")[19].text
			    player2.receptions = espnPlayer.css(".playertableStat")[20].text
			    player2.receiving_yards = espnPlayer.css(".playertableStat")[21].text
    			player2.receiving_tds = espnPlayer.css(".playertableStat")[22].text
    			player2.fpoints = espnPlayer.css(".playertableStat")[23].text

				player2.save
		    end
		end 
	end
	def espnWideReceivers(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# interate through webpage
		doc.css(".tableBody").each do |espnPlayer|

			# create new (blank) player
			player = Player.new

		#### Player NAME
			# add data from page to new (blank player)
			player.name = espnPlayer.css(".tableSubHead td:nth-child(1)").text#.split(/./)[1].strip
			if player.name != ""

				#parse player name to get team and position
				player.team = player.name.split(/,/)[1].strip.split(" ")[0]
				player.position = player.name.split(/,/)[1].strip.split(" ")[1]
				player.name = parseESPNPlayerName(player.name)
				player.picture_url = espnPlayer.css("img:nth-child(1)").attribute('src').to_s.split("&")[0]

				#### Year = 2013
			 	player.source = "ESPN"
			 	player.stat_year = 2013
			    player.targets = espnPlayer.css(".playertableStat")[9].text
			    player.receptions = espnPlayer.css(".playertableStat")[10].text
			    player.receiving_yards = espnPlayer.css(".playertableStat")[11].text
			    player.receiving_tds = espnPlayer.css(".playertableStat")[13].text
				player.rushes = espnPlayer.css(".playertableStat")[14].text
				player.rush_yards = espnPlayer.css(".playertableStat")[15].text
			    player.rush_tds = espnPlayer.css(".playertableStat")[16].text
    			player.fpoints = espnPlayer.css(".playertableStat")[17].text

				player.save

				#### Year = 2014
				player2 = Player.new
				player2.team = player.team
				player2.position = player.position
				player2.name = player.name
				player2.picture_url = player.picture_url

			  	player2.source = "ESPN"
			  	player2.stat_year = 2014
			    player2.targets = espnPlayer.css(".playertableStat")[18].text
			    player2.receptions = espnPlayer.css(".playertableStat")[19].text
			    player2.receiving_yards = espnPlayer.css(".playertableStat")[20].text
			    player2.receiving_tds = espnPlayer.css(".playertableStat")[22].text
				player2.rushes = espnPlayer.css(".playertableStat")[23].text
				player2.rush_yards = espnPlayer.css(".playertableStat")[24].text
			    player2.rush_tds = espnPlayer.css(".playertableStat")[25].text
    			player2.fpoints = espnPlayer.css(".playertableStat")[26].text

				player2.save
		    end
		end
	end
	def espnDefenses(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# interate through webpage
		doc.css(".tableBody").each do |espnPlayer|

			# create new (blank) player
			player = Player.new

		#### Player NAME
			# add data from page to new (blank player)
			player.name = espnPlayer.css(".tableSubHead td:nth-child(1)").text#.split(/./)[1].strip
			if player.name != ""

				#parse player name to get team and position
				player.team = player.name.split(" ")[1].strip
				player.position = player.name.split(" ")[2].strip
				player.name = player.team
				player.picture_url = espnPlayer.css(".tableBody img").attribute('src').to_s.split("&")[0]
    
				# #### Year = 2013
			 	player.source = "ESPN"
			 	player.stat_year = 2013
				player.sacks = espnPlayer.css(".playertableStat")[7].text
				player.interceptions = espnPlayer.css(".playertableStat")[8].text
				player.fumble_recoveries = espnPlayer.css(".playertableStat")[9].text
				player.rush_tds = espnPlayer.css(".playertableStat")[10].text
				player.points_against = espnPlayer.css(".playertableStat")[11].text
				player.yards_against = espnPlayer.css(".playertableStat")[12].text
				player.fpoints = espnPlayer.css(".playertableStat")[13].text

				player.save

				#### Year = 2014
				player2 = Player.new
				player2.team = player.team
				player2.position = player.position
				player2.name = player.name
				player2.picture_url = player.picture_url

			  	player2.source = "ESPN"
			  	player2.stat_year = 2014
				player2.sacks = espnPlayer.css(".playertableStat")[14].text
				player2.interceptions = espnPlayer.css(".playertableStat")[15].text
				player2.fumble_recoveries = espnPlayer.css(".playertableStat")[16].text
				player2.rush_tds = espnPlayer.css(".playertableStat")[17].text
				player2.points_against = espnPlayer.css(".playertableStat")[18].text
				player2.yards_against = espnPlayer.css(".playertableStat")[19].text
				player2.fpoints = espnPlayer.css(".playertableStat")[20].text

				player2.save
		    end
		end 
	end
	def espnKickers(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# interate through webpage
		doc.css(".tableBody").each do |espnPlayer|

			# create new (blank) player
			player = Player.new

		#### Player NAME
			# add data from page to new (blank player)
			player.name = espnPlayer.css(".tableSubHead td:nth-child(1)").text#.split(/./)[1].strip
			if player.name != ""

				#parse player name to get team and position
				player.team = player.name.split(/,/)[1].strip.split(" ")[0]
				player.position = player.name.split(/,/)[1].strip.split(" ")[1]
				player.name = parseESPNPlayerName(player.name)
				player.picture_url = espnPlayer.css("img:nth-child(1)").attribute('src').to_s.split("&")[0]

				#### Year = 2013
			 	player.source = "ESPN"
			 	player.stat_year = 2013
			
				player.kicking_attempts_1_to_39 = espnPlayer.css(".playertableStat")[6].text.split("/")[1]
				player.kicking_completions_1_to_39 = espnPlayer.css(".playertableStat")[6].text.split("/")[0]
				player.kicking_attempts_40_to_49 = espnPlayer.css(".playertableStat")[7].text.split("/")[1]
				player.kicking_completions_40_to_49 = espnPlayer.css(".playertableStat")[7].text.split("/")[0]
				player.kicking_attempts_over_50 = espnPlayer.css(".playertableStat")[8].text.split("/")[1]
				player.kicking_completions_over_50 = espnPlayer.css(".playertableStat")[8].text.split("/")[0]
				player.kicking_attempts_total = espnPlayer.css(".playertableStat")[9].text.split("/")[1]
				player.kicking_completions_total = espnPlayer.css(".playertableStat")[9].text.split("/")[0]
				player.kicking_attempts_XP = espnPlayer.css(".playertableStat")[10].text.split("/")[1]
				player.kicking_completions_XP = espnPlayer.css(".playertableStat")[10].text.split("/")[0]
				player.fpoints = espnPlayer.css(".playertableStat")[11].text

				player.save

				#### Year = 2014
				player2 = Player.new
				player2.team = player.team
				player2.position = player.position
				player2.name = player.name
				player2.picture_url = player.picture_url

			  	player2.source = "ESPN"
			  	player2.stat_year = 2014
				player2.kicking_attempts_1_to_39 = espnPlayer.css(".playertableStat")[12].text.split("/")[1]
				player2.kicking_completions_1_to_39 = espnPlayer.css(".playertableStat")[12].text.split("/")[0]
				player2.kicking_attempts_40_to_49 = espnPlayer.css(".playertableStat")[13].text.split("/")[1]
				player2.kicking_completions_40_to_49 = espnPlayer.css(".playertableStat")[13].text.split("/")[0]
				player2.kicking_attempts_over_50 = espnPlayer.css(".playertableStat")[14].text.split("/")[1]
				player2.kicking_completions_over_50 = espnPlayer.css(".playertableStat")[14].text.split("/")[0]
				player2.kicking_attempts_total = espnPlayer.css(".playertableStat")[15].text.split("/")[1]
				player2.kicking_completions_total = espnPlayer.css(".playertableStat")[15].text.split("/")[0]
				player2.kicking_attempts_XP = espnPlayer.css(".playertableStat")[16].text.split("/")[1]
				player2.kicking_completions_XP = espnPlayer.css(".playertableStat")[16].text.split("/")[0]
				player2.fpoints = espnPlayer.css(".playertableStat")[17].text

				player2.save
		    end
		end 
	end		
	def parseESPNPlayerName(player_name)
		if (player_name.split(/,/)[0].count ".").to_i > 1
			name_array = player_name.split(/,/)[0].split(".")
			name_array.shift
			return name_array.join(" ")
		else
			return player_name.split(/,/)[0].split(".")[1].strip
		end
	end
	def getWebsiteAsNokogiriDoc(url)
		require 'nokogiri'
		require 'open-uri'
		return Nokogiri::HTML(open(url))
	end
  	def self.to_csv(all_items)
		CSV.generate do |csv|
		  csv << column_names
		  all_items.each do |item|
		    csv << item.attributes.values_at(*column_names)
		  end
		end
	end
end