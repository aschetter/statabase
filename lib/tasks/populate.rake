require_relative './persistSeason.rb'
require_relative './persistTeam.rb'
require_relative './persistSeasonTeam.rb'
require_relative './loadPage.rb'
require_relative './parseBios.rb'
require_relative './persistBios.rb'
require_relative './persistRoster.rb'

require_relative './parseStats.rb'
require_relative './persistStats.rb'

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

  # XXXXXXXXXXXXXXXXX PARSE PLAYER STATS XXXXXXXXXXXXXXXXX

    player_statlines = parseStats(attrs, htmlPage)

  # XXXXXXXXXXXXXXXXX PERSIST PLAYER STAT LINES XXXXXXXXXXXXXXXXX

    persistStats(attrs, player_statlines)

    # parse_advanceds
    # persist_advanceds

    # parse_salaries
    # persist_salaries

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
