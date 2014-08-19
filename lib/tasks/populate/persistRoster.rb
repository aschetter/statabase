module BBall
  
  def self.persistRoster(attrs, team_players)
    
    puts ""
    puts "#{attrs[:@db_season].year} #{attrs[:@db_team].br_id} ADDED THE FOLLOWING PLAYERS TO ITS ROSTER:"

    team_players[:added].each do |player|
      Membership.create(player_id: player.id, team_id: attrs[:@db_team][:id], season_id: attrs[:@db_season][:id])
      puts player.name
    end

    team_players[:in_db].each do |player|
      Membership.create(player_id: player.id, team_id: attrs[:@db_team][:id], season_id: attrs[:@db_season][:id])
      puts player.name
    end
  end
end
