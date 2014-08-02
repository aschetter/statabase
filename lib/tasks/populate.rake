require_relative './loadPage.rb'

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    # XXXXXXXXXXXXXXXXX PERSIST SEASON XXXXXXXXXXXXXXXXX

    year   = 2014

    season = Season.create(year: year)

    # XXXXXXXXXXXXXXXXX PERSIST TEAM XXXXXXXXXXXXXXXXX

    br_id = 20

    teams = 
      [ "ATL", "BOS", "NJN", "CHA", "CHI", "CLE", "DAL", "DEN", 
        "DET", "GSW", "HOU", "IND", "LAC", "LAL", "MEM", "MIA", 
        "MIL", "MIN", "NOH", "NYK", "OKC", "ORL", "PHI", "PHO", 
        "POR", "SAC", "SAS", "TOR", "UTA", "WAS" ]
    
    team = season.teams.find_by(br_id: teams[br_id])

    if team.nil?
       
      puts "TEAM ISN'T IN THE DATABASE. ADDING TO THE DATABASE: #{teams[br_id]}"
      team = season.teams.create(br_id: teams[br_id])

      attrs = {
          season: season,
          team: team
      }

      doc = StatLoader::LoadPage.run(attrs)

      doc[:players].map do |player|
        player = player.css('td')

        href = player[1].css('a').attr("href").value
        br_id = href.slice(11..(href.index('.')-1))

        name = player[1].text
        number = player[0].text.to_i
        position = player[2].text
        height = player[3].text

        weight = player[4].text
        birth_date = player[5].text
        experience = player[6].text
        college = player[7].text
        
        team.players.create(
          br_id: br_id,
          name: name,
          number: number,
          position: position,

          height: height,
          weight: weight,
          birth_date: birth_date,
          experience: experience,
          college: college
        )
      end

      doc[:stats].map do |player|
        stat = player.css('td')

        href = stat[1].css('a').attr("href").value
        br_id = href.slice(11..(href.index('.')-1))

        player = team.players.find_by(br_id: br_id)

        age = stat[2].text.to_i
        gp = stat[3].text.to_i
        gs = stat[4].text.to_i
        min = stat[5].text

        fg_made = stat[6].text
        fg_att = stat[7].text
        fg_pct = stat[8].text
        three_made = stat[9].text

        three_att = stat[10].text
        three_pct = stat[11].text
        two_made = stat[12].text
        two_att = stat[13].text

        two_pct = stat[14].text
        ft_made = stat[15].text
        ft_att = stat[16].text
        ft_pct = stat[17].text

        orb = stat[18].text
        drb = stat[19].text
        trb = stat[20].text
        ast = stat[21].text

        stl = stat[22].text
        blk = stat[23].text
        tov = stat[24].text
        pf = stat[25].text
        pts = stat[26].text
        
        player.stats.create(
          br_id: br_id,
          age: age,
          gp: gp,
          gs: gs,
          min: min,

          fg_made: fg_made,
          fg_att: fg_att,
          fg_pct: fg_pct,
          three_made: three_made,

          three_att: three_att,
          three_pct: three_pct,
          two_made: two_made,
          two_att: two_att,

          two_pct: two_pct,
          ft_made: ft_made,
          ft_att: ft_att,
          ft_pct: ft_pct,

          orb: orb,
          drb: drb,
          trb: trb,
          ast: ast,

          stl: stl,
          blk: blk,
          tov: tov,
          pf: pf,
          pts: pts,
        )
      end
    else
        puts "TEAM IS ALREADY IN THE DATABASE. THE INFO WILL NOT BE ADDED"
    end





  end
end
