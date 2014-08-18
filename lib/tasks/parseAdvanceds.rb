def parseAdvanceds(attrs, htmlPage)

  puts ""
  puts "#{attrs[:@db_season].year} #{attrs[:@db_team].br_id} ADDED ADVANCED STATS FOR THE FOLLOWING PLAYERS:"

  advs = htmlPage[:advs]

  player_advanceds = []

  advs.each do |player|
    advanced_info = player.css('td')
    href = advanced_info[1].css('a').attr("href").value

    player_advanced = {
      br_id: href.slice(11..(href.index('.')-1)),
      per: advanced_info[5].text,
      ts_pct: advanced_info[6].text,
      efg_pct: advanced_info[7].text,
      ft_ar: advanced_info[8].text,
      three_ar: advanced_info[9].text,

      orb_pct: advanced_info[10].text,
      drb_pct: advanced_info[11].text,
      trb_pct: advanced_info[12].text,
      ast_pct: advanced_info[13].text,
      stl_pct: advanced_info[14].text,

      blk_pct: advanced_info[15].text,
      tov_pct: advanced_info[16].text,
      usg_pct: advanced_info[17].text,
      o_rtg: advanced_info[18].text,
      d_rtg: advanced_info[19].text,

      ows: advanced_info[20].text,
      dws: advanced_info[21].text,
      ws: advanced_info[22].text,
      ws_48: advanced_info[23].text
    }

    player_advanceds << player_advanced
  end

  player_advanceds
end
