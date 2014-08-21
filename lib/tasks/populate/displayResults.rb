module BBall

  def self.displayResults(attrs)  

    puts ""
    puts "TEAM: #{attrs[:@db_team].br_id}"
    puts "SEASON: #{attrs[:@db_season].year}"
    puts ""
    puts "PLAYERS ADDED TO DB: #{attrs[:players][:added]}"
    puts "PLAYERS ALREADY IN DB: #{attrs[:players][:already_in_db]}"
    puts "SEASON STATS ADDED: #{attrs[:statlines][:added]}"
    puts "ADVANCED STATS ADDED: #{attrs[:advanceds][:added]}"
    puts "JUST PLAYER SALARY ADDED: #{attrs[:salaries][:added]}"
    puts "PLAYERS UPDATED WITH SALARY INFO: #{attrs[:salaries][:updated]}"

  end
end
