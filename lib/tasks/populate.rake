require_relative './loadPage.rb'

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    # XXXXXXXXXXXXXXXXX CREATE SEASON XXXXXXXXXXXXXXXXX

    year = 2014

    @db_season = Season.find_by(year: year)

    if @db_season.nil?
      @db_season = Season.create(year: year)
      puts ""
      puts "ADDED TO THE DATABASE: #{@db_season.year}"
    else
      puts ""
      puts "#{@db_season.year} IS ALREADY IN THE DATABASE."
    end

    # XXXXXXXXXXXXXXXXX CREATE TEAM XXXXXXXXXXXXXXXXX

    # br_id corresponds to unique team ID in the online database

    br_id = 28

    teams = %w[ ATL BOS BRK CHA CHI CLE DAL DEN DET GSW 
                HOU IND LAC LAL MEM MIA MIL MIN NOP NYK
                OKC ORL PHI PHO POR SAC SAS TOR UTA WAS ]
    
    @db_team = Team.find_by(br_id: teams[br_id])

    if @db_team.nil?
      @db_team = Team.create(br_id: teams[br_id])
      puts ""
      puts "ADDED TO THE DATABASE: #{@db_team.br_id}"
    else
      puts ""
      puts "#{@db_team.br_id} IS ALREADY IN THE DATABASE."
    end

    # XXXXXXXXXXXXXXXXX CREATE SEASON TEAM XXXXXXXXXXXXXXXXX

    @db_season_team = SeasonTeam.find_by(season_id: @db_season[:id], team_id: @db_team[:id])

    if @db_season_team.nil?
      @db_season_team = SeasonTeam.create(season_id: @db_season[:id], team_id: @db_team[:id])
    end

    # XXXXXXXXXXXXXXXXX LOAD TEAM STAT PAGE XXXXXXXXXXXXXXXXX

      attrs = {
          season: @db_season,
          team: @db_team
      }

      doc = StatLoader::LoadPage.run(attrs)

    # XXXXXXXXXXXXXXXXX PARSE PLAYER BIOS XXXXXXXXXXXXXXXXX

      players = doc[:players]

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

    # XXXXXXXXXXXXXXXXX CREATE PLAYER BIOS XXXXXXXXXXXXXXXXX

      basic_info = {
        added: 0,
        already_in_db: 0
      }

      team_players = {
        added: [],
        in_db: []
      }

      player_bios.each do |player|

        @db_player = Player.find_by(br_id: player[:br_id])

        if @db_player.nil?

          @db_player = Player.create(
            br_id: player[:br_id],
            name: player[:name],
            number: player[:number],
            position: player[:position],

            height: player[:height],
            weight: player[:weight],
            birth_date: player[:birth_date],
            experience: player[:experience],
            college: player[:college]
          )

          basic_info[:added] += 1
          team_players[:added] << @db_player

        else

          basic_info[:already_in_db] += 1
          team_players[:in_db] << @db_player
        end
      end

      puts ""
      puts "ADDED BASIC INFO FOR:"

      team_players[:added].each do |player|
        puts player.name
      end

      puts ""
      puts "THESE PLAYERS WERE ALREADY IN THE DB:"

      team_players[:in_db].each do |player|
        puts player.name
      end

      # XXXXXXXXXXXXXXXXX CREATE TEAM ROSTER XXXXXXXXXXXXXXXXX

      puts ""
      puts "#{@db_season.year} #{@db_team.br_id} ADDED THE FOLLOWING PLAYERS TO ITS ROSTER:"

      team_players[:added].each do |player|
        Membership.create(player_id: player.id, team_id: @db_team[:id], season_id: @db_season[:id])
        puts player.name
      end

      team_players[:in_db].each do |player|
        Membership.create(player_id: player.id, team_id: @db_team[:id], season_id: @db_season[:id])
        puts player.name
      end

      # XXXXXXXXXXXXXXXXX CREATE PLAYER STAT LINE XXXXXXXXXXXXXXXXX

      puts ""
      puts "#{@db_season.year} #{@db_team.br_id} ADDED A STAT LINE FOR THE FOLLOWING PLAYERS:"

      statlines = {
        added: 0
      }

      stats = doc[:stats]

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

      player_statlines.each do |player|

        db_player = Player.find_by(br_id: player[:br_id])
        membership = Membership.find_by(season_id: @db_season, team_id: @db_team[:id], player_id: db_player[:id])
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

        puts "#{db_player.name}"
        statlines[:added] += 1
      end







    #   advs = {
    #     added: 0
    #   }

    #   puts ""
    #   puts "ADDED ADVANCED STATS FOR:"

    #   advs = doc[:advs]

    #   advs.map do |player|
    #     advanced_info = player.css('td')

    #     href = advanced_info[1].css('a').attr("href").value
    #     br_id = href.slice(11..(href.index('.')-1))

    #     player = team.players.find_by(br_id: br_id)

    #     per = advanced_info[5].text
    #     ts_pct = advanced_info[6].text
    #     efg_pct = advanced_info[7].text
    #     ft_ar = advanced_info[8].text
    #     three_ar = advanced_info[9].text

    #     orb_pct = advanced_info[10].text
    #     drb_pct = advanced_info[11].text
    #     trb_pct = advanced_info[12].text
    #     ast_pct = advanced_info[13].text
    #     stl_pct = advanced_info[14].text

    #     blk_pct = advanced_info[15].text
    #     tov_pct = advanced_info[16].text
    #     usg_pct = advanced_info[17].text
    #     o_rtg = advanced_info[18].text
    #     d_rtg = advanced_info[19].text

    #     ows = advanced_info[20].text
    #     dws = advanced_info[21].text
    #     ws = advanced_info[22].text
    #     ws_48 = advanced_info[23].text

    #     boy = player.create_adv(
    #       br_id: br_id,
    #       per: per,
    #       ts_pct: ts_pct, 
    #       efg_pct: efg_pct,

    #       ft_ar: ft_ar,
    #       three_ar: three_ar,
    #       orb_pct: orb_pct,
    #       drb_pct: drb_pct,

    #       trb_pct: trb_pct,
    #       ast_pct: ast_pct,
    #       stl_pct: stl_pct,
    #       blk_pct: blk_pct,

    #       tov_pct: tov_pct,
    #       usg_pct: usg_pct,
    #       o_rtg: o_rtg,
    #       d_rtg: d_rtg,

    #       ows: ows,
    #       dws: dws,
    #       ws: ws,
    #       ws_48: ws_48
    #     )
        
    #     puts "#{player.name}"
    #     advs[:added] += 1
    #   end

    #   @salary = {
    #     added: 0,
    #     updated: 0
    #   }

    #   @added = []
    #   @updated = []

    #   doc[:salaries].map do |player|

    #     salary_info = player.css('td')

    #     href = salary_info[1].css('a').attr("href").value
    #     br_id = href.slice(11..(href.index('.')-1))

    #     player = team.players.find_by(br_id: br_id)

    #     name = salary_info[1].css('a').text
    #     salary = salary_info[2].attr("csk").to_i

    #     if player.nil?
    #       player = team.players.create(
    #         br_id: br_id,
    #         name: name,
    #         salary: salary
    #       )

    #       @added << player.name
    #       @salary[:added] += 1

    #     else
    #       player.name = name
    #       player.salary = salary
    #       player.save

    #       @updated << player.name
    #       @salary[:updated] += 1
    #     end
    #   end

    #   puts ""    
    #   puts "PLAYERS ADDED WITH JUST SALARY:"
    #   @added.each do |player|
    #     puts player
    #   end

    #   puts ""    
    #   puts "ADDED SALARY TO:"
    #   @updated.each do |player|
    #     puts player
    #   end

    #   puts ""
    #   puts "PLAYERS BASIC INFO ADDED: #{basic_info[:added]}"
    #   puts "SEASON TOTALS ADDED: #{stats[:added]}"
    #   puts "ADVANCED STATS ADDED: #{advs[:added]}"
    #   puts "JUST PLAYER SALARY ADDED: #{@salary[:added]}"
    #   puts "PLAYERS UPDATED WITH SALARY INFO: #{@salary[:updated]}"
      

  end
end
