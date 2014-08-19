def adjustPlayerSalaries(percentages)

  percentages.each do |percentage|
    percentage.each do |membership|

      total_salary = membership[:total_salary]
      gp_percentage = membership[:gp_percentage]

      db_membership = Membership.find(membership[:membership_id])

      player = Player.find(db_membership.player_id)
      team = Team.find(db_membership.team_id)
      season = Season.find(db_membership.season_id)

      db_membership.salary = total_salary * gp_percentage
      db_membership.save

      puts "PLAYER: #{player.name}, TEAM: #{team.br_id}, SEASON: #{season.year}, NEW SALARY: #{db_membership.salary}"
    end
  end
end
