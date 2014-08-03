require_relative './loadPage.rb'

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    # XXXXXXXXXXXXXXXXX PERSIST SEASON XXXXXXXXXXXXXXXXX

    year   = 2014

    season = Season.find_by(year: year)

    if season.nil?
      season = Season.create(year: year)
      puts ""
      puts "ADDED TO THE DATABASE: #{season.year}"
      puts ""
    end

    # XXXXXXXXXXXXXXXXX PERSIST TEAM XXXXXXXXXXXXXXXXX

    br_id = 27

    teams = 
      [ "ATL", "BOS", "NJN", "CHA", "CHI", "CLE", "DAL", "DEN", 
        "DET", "GSW", "HOU", "IND", "LAC", "LAL", "MEM", "MIA", 
        "MIL", "MIN", "NOH", "NYK", "OKC", "ORL", "PHI", "PHO", 
        "POR", "SAC", "SAS", "TOR", "UTA", "WAS" ]
    
    team = season.teams.find_by(br_id: teams[br_id])

    if team.nil?
       
      team = season.teams.create(br_id: teams[br_id])
      puts ""
      puts "ADDED TO THE DATABASE: #{team.br_id}"

      attrs = {
          season: season,
          team: team
      }

      doc = StatLoader::LoadPage.run(attrs)

      basic_info = {
        added: 0
      }

      puts ""
      puts "ADDED BASIC INFO FOR:"

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
        
        player = team.players.create(
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

        puts "#{player.name}"
        basic_info[:added] += 1
      end


      stats = {
        added: 0
      }

      puts ""
      puts "ADDED SEASON TOTALS FOR:"

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
        
        player.create_stat(
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
          pf:  pf,
          pts: pts,
        )
        puts "#{player.name}"
        stats[:added] += 1
      end

      advs = {
        added: 0
      }

      puts ""
      puts "ADDED ADVANCED STATS FOR:"

      doc[:advs].map do |player|
        advanced_info = player.css('td')

        href = advanced_info[1].css('a').attr("href").value
        br_id = href.slice(11..(href.index('.')-1))

        player = team.players.find_by(br_id: br_id)

        per = advanced_info[5].text
        ts_pct = advanced_info[6].text
        efg_pct = advanced_info[7].text
        ft_ar = advanced_info[8].text
        three_ar = advanced_info[9].text

        orb_pct = advanced_info[10].text
        drb_pct = advanced_info[11].text
        trb_pct = advanced_info[12].text
        ast_pct = advanced_info[13].text
        stl_pct = advanced_info[14].text

        blk_pct = advanced_info[15].text
        tov_pct = advanced_info[16].text
        usg_pct = advanced_info[17].text
        o_rtg = advanced_info[18].text
        d_rtg = advanced_info[19].text

        ows = advanced_info[20].text
        dws = advanced_info[21].text
        ws = advanced_info[22].text
        ws_48 = advanced_info[23].text

        boy = player.create_adv(
          br_id: br_id,
          per: per,
          ts_pct: ts_pct, 
          efg_pct: efg_pct,

          ft_ar: ft_ar,
          three_ar: three_ar,
          orb_pct: orb_pct,
          drb_pct: drb_pct,

          trb_pct: trb_pct,
          ast_pct: ast_pct,
          stl_pct: stl_pct,
          blk_pct: blk_pct,

          tov_pct: tov_pct,
          usg_pct: usg_pct,
          o_rtg: o_rtg,
          d_rtg: d_rtg,

          ows: ows,
          dws: dws,
          ws: ws,
          ws_48: ws_48
        )
        
        puts "#{player.name}"
        advs[:added] += 1
      end

      @salary = {
        added: 0,
        updated: 0
      }

      @added = []
      @updated = []

      doc[:salaries].map do |player|

        salary_info = player.css('td')

        href = salary_info[1].css('a').attr("href").value
        br_id = href.slice(11..(href.index('.')-1))

        player = team.players.find_by(br_id: br_id)

        name = salary_info[1].css('a').text
        salary = salary_info[2].attr("csk").to_i

        if player.nil?
          player = team.players.create(
            br_id: br_id,
            name: name,
            salary: salary
          )

          @added << player.name
          @salary[:added] += 1

        else
          player.name = name
          player.salary = salary
          player.save

          @updated << player.name
          @salary[:updated] += 1
        end
      end

      puts ""    
      puts "PLAYERS ADDED WITH JUST SALARY:"
      @added.each do |player|
        puts player
      end

      puts ""    
      puts "ADDED SALARY TO:"
      @updated.each do |player|
        puts player
      end

      puts ""
      puts "PLAYERS BASIC INFO ADDED: #{basic_info[:added]}"
      puts "SEASON TOTALS ADDED: #{stats[:added]}"
      puts "ADVANCED STATS ADDED: #{advs[:added]}"
      puts "JUST PLAYER SALARY ADDED: #{@salary[:added]}"
      puts "PLAYERS UPDATED WITH SALARY INFO: #{@salary[:updated]}"

    else
        puts ""
        puts "TEAM IS ALREADY IN THE DATABASE. THE INFO WILL NOT BE ADDED"
    end
  end
end
