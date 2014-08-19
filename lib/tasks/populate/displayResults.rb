module BBall

  def self.displayResults(attrs)  

    puts ""
    puts "TEAM: #{attrs[:@db_team].br_id}"
    puts "SEASON: #{attrs[:@db_season].year}"
    puts ""
    puts "PLAYERS ADDED TO DB: #{$team_stats[:players][:added]}"
    puts "PLAYERS ALREADY IN DB: #{$team_stats[:players][:already_in_db]}"
    puts "SEASON STATS ADDED: #{$team_stats[:statlines][:added]}"
    puts "ADVANCED STATS ADDED: #{$team_stats[:advanceds][:added]}"
    puts "JUST PLAYER SALARY ADDED: #{$team_stats[:salaries][:added]}"
    puts "PLAYERS UPDATED WITH SALARY INFO: #{$team_stats[:salaries][:updated]}"

    $team_stats = {}
  end
end
