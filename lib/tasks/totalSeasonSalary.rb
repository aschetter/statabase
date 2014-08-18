def totalSeasonSalary(players_memberships)

  @players = []

  players_memberships.each do |player_memberships|

    @player = {
      player_id: nil,
      memberships: [],
      total: []
    }

    @stats = {
      total_salary: 0,
      total_games: 0
    }

    player_memberships.each do |membership|

      @stats[:total_salary] += membership.salary.to_i
      @stats[:total_games] += membership.stat.gp.to_i

      membership_id = membership.id

      stats = { membership_id: membership_id, gp: membership.stat.gp.to_i, salary: membership.salary }
      @player[:memberships] << stats
    end

    total = { totalGP: @stats[:total_games], totalSalary: @stats[:total_salary] }
    @player[:total] = total

    @players << @player
  end

  @players
end
