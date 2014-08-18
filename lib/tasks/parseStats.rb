def parseStats(attrs, htmlPage)

  puts ""
  puts "#{attrs[:@db_season].year} #{attrs[:@db_team].br_id} ADDED A STAT LINE FOR THE FOLLOWING PLAYERS:"

  stats = htmlPage[:stats]

  player_statlines = []

  stats.each do |player|
    stat = player.css('td')
    href = stat[1].css('a').attr("href").value

    player_statline = {
      br_id: href.slice(11..(href.index('.')-1)),
      age: stat[2].text.to_i,
      gp: stat[3].text.to_i,
      gs: stat[4].text.to_i,
      min: stat[5].text,

      fg_made: stat[6].text,
      fg_att: stat[7].text,
      fg_pct: stat[8].text,
      three_made: stat[9].text,

      three_att: stat[10].text,
      three_pct: stat[11].text,
      two_made: stat[12].text,
      two_att: stat[13].text,

      two_pct: stat[14].text,
      ft_made: stat[15].text,
      ft_att: stat[16].text,
      ft_pct: stat[17].text,

      orb: stat[18].text,
      drb: stat[19].text,
      trb: stat[20].text,
      ast: stat[21].text,

      stl: stat[22].text,
      blk: stat[23].text,
      tov: stat[24].text,
      pf: stat[25].text,
      pts: stat[26].text
    }

    player_statlines << player_statline
  end

  player_statlines
end
