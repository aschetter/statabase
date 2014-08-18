def calculateGamePercentages(player_salaries)

  @stats = []

  player_salaries.each do |player|

    @game_percentages = []

    player[:memberships].each do |membership|
      team_games = membership[:gp].to_f
      season_games = player[:total][:totalGP]
      total_salary = player[:total][:totalSalary]

      gp_percentage = team_games / season_games
      gp_percentage = ( gp_percentage * 100 ).round / 100.0

      game_percentage = { membership_id: membership[:membership_id], gp_percentage: gp_percentage, total_salary: total_salary }

      @game_percentages << game_percentage
    end

  @stats << @game_percentages
  end

  @stats
end
