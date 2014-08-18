def parseBios(htmlPage)
  players = htmlPage[:players]

  player_bios = []

  players.each do |player|
    player = player.css('td')
    href = player[1].css('a').attr("href").value

    player_bio = {
      br_id: href.slice(11..(href.index('.')-1)),
      name: player[1].text,
      number: player[0].text.to_i,
      position: player[2].text,

      height: player[3].text,
      weight: player[4].text,
      birth_date: player[5].text,
      experience: player[6].text,
      college: player[7].text,
    }

    player_bios << player_bio
  end

  player_bios
end
