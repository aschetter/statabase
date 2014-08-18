require_relative './persistSeason.rb'
require_relative './persistTeam.rb'
require_relative './persistSeasonTeam.rb'
require_relative './loadPage.rb'
require_relative './parseBios.rb'
require_relative './persistBios.rb'
require_relative './persistRoster.rb'

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    attrs = {}

  # XXXXXXXXXXXXXXXXX PERSIST SEASON XXXXXXXXXXXXXXXXX

    attrs[:@db_season] = persistSeason(2014)

  # XXXXXXXXXXXXXXXXX PERSIST TEAM XXXXXXXXXXXXXXXXX

    # br_id: unique team ID in the online database (0-29)
    br_id = 25

    attrs[:@db_team] = persistTeam(br_id)

  # XXXXXXXXXXXXXXXXX PERSIST SEASON_TEAM XXXXXXXXXXXXXXXXX

    persistSeasonTeam(attrs)

  # XXXXXXXXXXXXXXXXX LOAD HTML PAGE XXXXXXXXXXXXXXXXX

    htmlPage = LoadPage(attrs)

  # XXXXXXXXXXXXXXXXX PARSE PLAYER BIOS XXXXXXXXXXXXXXXXX

    player_bios = parseBios(htmlPage)

  # XXXXXXXXXXXXXXXXX PERSIST PLAYER BIOS XXXXXXXXXXXXXXXXX
  
    team_players = persistBios(player_bios)

  # XXXXXXXXXXXXXXXXX PERSIST TEAM ROSTER XXXXXXXXXXXXXXXXX

    persistRoster(attrs, team_players)

    # parse_statlines
    # persist_statlines

    # parse_advanceds
    # persist_advanceds

    # parse_salaries
    # persist_salaries

# # XXXXXXXXXXXXXXXXX PARSE PLAYER STAT LINES XXXXXXXXXXXXXXXXX

#     puts ""
#     puts "#{@db_season.year} #{@db_team.br_id} ADDED A STAT LINE FOR THE FOLLOWING PLAYERS:"

#     statlines = {
#       added: 0
#     }

#     stats = htmlPage[:stats]

#     player_statlines = []

#     stats.each do |player|
#       stat = player.css('td')
#       href = stat[1].css('a').attr("href").value

#       player_statline = {
#         br_id: href.slice(11..(href.index('.')-1)),
#         age: stat[2].text.to_i,
#         gp: stat[3].text.to_i,
#         gs: stat[4].text.to_i,
#         min: stat[5].text,

#         fg_made: stat[6].text,
#         fg_att: stat[7].text,
#         fg_pct: stat[8].text,
#         three_made: stat[9].text,

#         three_att: stat[10].text,
#         three_pct: stat[11].text,
#         two_made: stat[12].text,
#         two_att: stat[13].text,

#         two_pct: stat[14].text,
#         ft_made: stat[15].text,
#         ft_att: stat[16].text,
#         ft_pct: stat[17].text,

#         orb: stat[18].text,
#         drb: stat[19].text,
#         trb: stat[20].text,
#         ast: stat[21].text,

#         stl: stat[22].text,
#         blk: stat[23].text,
#         tov: stat[24].text,
#         pf: stat[25].text,
#         pts: stat[26].text
#       }

#       player_statlines << player_statline
#     end

# # XXXXXXXXXXXXXXXXX PERSIST PLAYER STAT LINES XXXXXXXXXXXXXXXXX

#     player_statlines.each do |player|
#       db_player = Player.find_by(br_id: player[:br_id])
#       membership = Membership.find_by(season_id: @db_season[:id], team_id: @db_team[:id], player_id: db_player[:id])
      
#       Stat.create(
#         membership_id: membership[:id],
#         age: player[:age],
#         gp: player[:gp],
#         gs: player[:gs],
#         min: player[:min],

#         fg_made: player[:fg_made],
#         fg_att: player[:fg_att],
#         fg_pct: player[:fg_pct],
#         three_made: player[:three_made],

#         three_att: player[:three_att],
#         three_pct: player[:three_pct],
#         two_made: player[:two_made],
#         two_att: player[:two_att],

#         two_pct: player[:two_pct],
#         ft_made: player[:ft_made],
#         ft_att: player[:ft_att],
#         ft_pct: player[:ft_pct],

#         orb: player[:orb],
#         drb: player[:drb],
#         trb: player[:trb],
#         ast: player[:ast],

#         stl: player[:stl],
#         blk: player[:blk],
#         tov: player[:tov],
#         pf: player[:pf],
#         pts: player[:pts],
#       )

#       puts db_player.name
#       statlines[:added] += 1
#     end

# # XXXXXXXXXXXXXXXXX PARSE PLAYER ADVANCED STATS XXXXXXXXXXXXXXXXX

#     puts ""
#     puts "#{@db_season.year} #{@db_team.br_id} ADDED ADVANCED STATS FOR THE FOLLOWING PLAYERS:"

#     advanced = {
#       added: 0
#     }

#     advs = htmlPage[:advs]

#     player_advanceds = []

#     advs.each do |player|
#       advanced_info = player.css('td')
#       href = advanced_info[1].css('a').attr("href").value

#       player_advanced = {
#         br_id: href.slice(11..(href.index('.')-1)),
#         per: advanced_info[5].text,
#         ts_pct: advanced_info[6].text,
#         efg_pct: advanced_info[7].text,
#         ft_ar: advanced_info[8].text,
#         three_ar: advanced_info[9].text,

#         orb_pct: advanced_info[10].text,
#         drb_pct: advanced_info[11].text,
#         trb_pct: advanced_info[12].text,
#         ast_pct: advanced_info[13].text,
#         stl_pct: advanced_info[14].text,

#         blk_pct: advanced_info[15].text,
#         tov_pct: advanced_info[16].text,
#         usg_pct: advanced_info[17].text,
#         o_rtg: advanced_info[18].text,
#         d_rtg: advanced_info[19].text,

#         ows: advanced_info[20].text,
#         dws: advanced_info[21].text,
#         ws: advanced_info[22].text,
#         ws_48: advanced_info[23].text
#       }

#       player_advanceds << player_advanced
#     end

# # XXXXXXXXXXXXXXXXX PERSIST PLAYER ADVANCED STATS XXXXXXXXXXXXXXXXX

#     player_advanceds.each do |player|
#       db_player = Player.find_by(br_id: player[:br_id])
#       membership = Membership.find_by(season_id: @db_season[:id], team_id: @db_team[:id], player_id: db_player[:id])
      
#       Adv.create(
#         membership_id: membership[:id],
#         per: player[:per],
#         ts_pct: player[:ts_pct], 
#         efg_pct: player[:efg_pct],

#         ft_ar: player[:ft_ar],
#         three_ar: player[:three_ar],
#         orb_pct: player[:orb_pct],
#         drb_pct: player[:drb_pct],

#         trb_pct: player[:trb_pct],
#         ast_pct: player[:ast_pct],
#         stl_pct: player[:stl_pct],
#         blk_pct: player[:blk_pct],

#         tov_pct: player[:tov_pct],
#         usg_pct: player[:usg_pct],
#         o_rtg: player[:o_rtg],
#         d_rtg: player[:d_rtg],

#         ows: player[:ows],
#         dws: player[:dws],
#         ws: player[:ws],
#         ws_48: player[:ws_48]
#       )

#       puts db_player.name
#       advanced[:added] += 1
#     end

# # XXXXXXXXXXXXXXXXX PARSE PLAYER SALARY INFO XXXXXXXXXXXXXXXXX

#     @salary = {
#       added: 0,
#       updated: 0
#     }

#     @added = []
#     @updated = []

#     player_salaries = []

#     salaries = htmlPage[:salaries]

#     salaries.each do |player|
#       salary_info = player.css('td')
#       href = salary_info[1].css('a').attr("href").value

#       player_salary = {
#         br_id: href.slice(11..(href.index('.')-1)),
#         name: salary_info[1].css('a').text,
#         salary: salary_info[2].attr("csk").to_i
#       }

#       player_salaries << player_salary
#     end

# # XXXXXXXXXXXXXXXXX PERSIST PLAYER SALARY INFO XXXXXXXXXXXXXXXXX

#     player_salaries.each do |player|
#       @db_player = Player.find_by(br_id: player[:br_id])

#       if @db_player.nil?
#         @db_player = Player.create(
#           br_id: player[:br_id],
#           name: player[:name]
#         )

#         Membership.create(player_id: @db_player.id, team_id: @db_team[:id], season_id: @db_season[:id], salary: player[:salary])

#         @added << @db_player.name
#         @salary[:added] += 1
        
#       else
#         membership = Membership.find_by(season_id: @db_season[:id], team_id: @db_team[:id], player_id: @db_player[:id])
#         membership.salary = player[:salary]
#         membership.save

#         @updated << @db_player.name
#         @salary[:updated] += 1
#       end
#     end

#     puts ""    
#     puts "PLAYERS ADDED WITH JUST SALARY:"
#     @added.each do |player|
#       puts player
#     end

#     puts ""    
#     puts "ADDED SALARY TO:"
#     @updated.each do |player|
#       puts player
#     end

#     puts ""
#     puts "PLAYERS BASIC INFO ADDED: #{basic_info[:added]}"
#     puts "SEASON TOTALS ADDED: #{statlines[:added]}"
#     puts "ADVANCED STATS ADDED: #{advanced[:added]}"
#     puts "JUST PLAYER SALARY ADDED: #{@salary[:added]}"
#     puts "PLAYERS UPDATED WITH SALARY INFO: #{@salary[:updated]}"
  end
end
