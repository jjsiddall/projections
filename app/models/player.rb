class Player < ActiveRecord::Base
  attr_accessible :attempts, :completions, :fpoints, :fumble_recoveries, :fumble_lost, :source, :interceptions, :kicking_attempts_1_to_39, :kicking_attempts_40_to_49, :kicking_attempts_XP, :kicking_attempts_over_50, :kicking_attempts_total, :kicking_completions_1_to_39, :kicking_completions_40_to_49, :kicking_completions_XP, :kicking_completions_over_50, :kicking_completions_total, :name, :pass_tds, :pass_yards, :picture_url, :points_against, :position, :receiving_tds, :receiving_yards, :receptions, :rush_tds, :rush_yards, :rushes, :sacks, :stat_year, :targets, :team, :yards_against

  	def self.to_csv(all_items)
		CSV.generate do |csv|
		  csv << column_names
		  all_items.each do |item|
		    csv << item.attributes.values_at(*column_names)
		  end
		end
	end

	def espnDataPull
		# allESPNProjections = Array.new
		# allESPNProjections.push(*getPlayers("Defenses", 30))	
		# allESPNProjections.push(*getPlayers("Kickers", 65))	
		getPlayers("Quarterbacks")
		getPlayers("Running Backs")
		getPlayers("Wide Receivers")
		getPlayers("Tight Ends")
		getPlayers("Defenses", 30)
		getPlayers("Kickers", 65)
		
		# espnKickers("http://games.espn.go.com/ffl/tools/projections?display=alt&slotCategoryId=17&startIndex=0")
	end

	def getPlayers(player_type, number_of_players = 80)
		allPlayers = Array.new
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
		return allPlayers
	end

	def espnQuarterbacks(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# declare and array to hold players (this will be what is returned)
		players = Array.new
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
				player.name = player.name.split(/,/)[0].split(".")[1].strip
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

				player.save!

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

				player2.save!
		    end
		end 
		# puts players.count
		return players
	end	
	def espnRunningBacks(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# declare and array to hold players (this will be what is returned)
		players = Array.new
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
				player.name = player.name.split(/,/)[0].split(".")[1].strip
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

				player.save!

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

				player2.save!
		    end
		end 
		# puts players.count
		return players
	end
	def espnWideReceivers(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# declare and array to hold players (this will be what is returned)
		players = Array.new
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
				player.name = player.name.split(/,/)[0].split(".")[1].strip
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

				player.save!

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

				player2.save!
		    end
		end
		return players 
	end
	def espnDefenses(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# declare and array to hold players (this will be what is returned)
		players = Array.new
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

				player.save!

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

				player2.save!
		    end
		end 
		return players
	end
	def espnKickers(url)
		# get webpage data using Nokogiri
		doc = getWebsiteAsNokogiriDoc(url)
		
		# declare and array to hold players (this will be what is returned)
		players = Array.new
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
				player.name = player.name.split(/,/)[0].split(".")[1].strip
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

				player.save!

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

				player2.save!
		    end
		end 
		return players
	end		
	def getWebsiteAsNokogiriDoc(url)
		require 'nokogiri'
		require 'open-uri'

		return Nokogiri::HTML(open(url))
	end
end