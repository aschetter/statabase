def totalSeasonSalary(players_memberships)

  players_memberships.each do |player_memberships|

    @total_salary = 0
    @total_games = 0

    player_memberships.each do |membership|

      @total_salary += membership.salary.to_i
      @total_games += membership.stat.gp.to_i

      player = Player.find(membership.player_id)
      team = Team.find(membership.team_id)

      puts "#{player.name}: team: #{team.br_id}, gp: #{membership.stat.gp.to_i}, salary: #{membership.salary}"

    end
      puts "TOTAL GP: #{@total_games}"
      puts "TOTAL SALARY: #{@total_salary}"
      puts ""
  end
end
