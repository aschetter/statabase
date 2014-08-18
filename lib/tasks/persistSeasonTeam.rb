def persistSeasonTeam(attrs)

  @db_season_team = SeasonTeam.find_by(season_id: attrs[:@db_season][:id], team_id: attrs[:@db_team][:id])

  if @db_season_team.nil?
    @db_season_team = SeasonTeam.create(season_id: attrs[:@db_season][:id], team_id: attrs[:@db_team][:id])
  end
  
end
