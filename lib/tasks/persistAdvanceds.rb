def persistAdvanceds(attrs, player_advanceds)

  player_advanceds.each do |player|

    db_player = Player.find_by(br_id: player[:br_id])
    membership = Membership.find_by(season_id: attrs[:@db_season][:id], team_id: attrs[:@db_team][:id], player_id: db_player[:id])
    
    Adv.create(
      membership_id: membership[:id],
      per: player[:per],
      ts_pct: player[:ts_pct], 
      efg_pct: player[:efg_pct],

      ft_ar: player[:ft_ar],
      three_ar: player[:three_ar],
      orb_pct: player[:orb_pct],
      drb_pct: player[:drb_pct],

      trb_pct: player[:trb_pct],
      ast_pct: player[:ast_pct],
      stl_pct: player[:stl_pct],
      blk_pct: player[:blk_pct],

      tov_pct: player[:tov_pct],
      usg_pct: player[:usg_pct],
      o_rtg: player[:o_rtg],
      d_rtg: player[:d_rtg],

      ows: player[:ows],
      dws: player[:dws],
      ws: player[:ws],
      ws_48: player[:ws_48]
    )

    puts db_player.name
    @team_stats[:advanceds][:added] += 1
  end
end
