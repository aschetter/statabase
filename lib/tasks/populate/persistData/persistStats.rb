module BBall
  
  def self.persistStats(attrs, player_statlines)

    player_statlines.each do |player|
      db_player = Player.find_by(br_id: player[:br_id])
      membership = Membership.find_by(season_id: attrs[:@db_season][:id], team_id: attrs[:@db_team][:id], player_id: db_player[:id])
      
      Stat.create(
        membership_id: membership[:id],
        age: player[:age],
        gp: player[:gp],
        gs: player[:gs],
        min: player[:min],

        fg_made: player[:fg_made],
        fg_att: player[:fg_att],
        fg_pct: player[:fg_pct],
        three_made: player[:three_made],

        three_att: player[:three_att],
        three_pct: player[:three_pct],
        two_made: player[:two_made],
        two_att: player[:two_att],

        two_pct: player[:two_pct],
        ft_made: player[:ft_made],
        ft_att: player[:ft_att],
        ft_pct: player[:ft_pct],

        orb: player[:orb],
        drb: player[:drb],
        trb: player[:trb],
        ast: player[:ast],

        stl: player[:stl],
        blk: player[:blk],
        tov: player[:tov],
        pf: player[:pf],
        pts: player[:pts],
      )

      $team_stats[:statlines][:added] += 1
      puts db_player.name
    end
  end
end
