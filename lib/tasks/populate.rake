require_relative './persistSeason.rb'
require_relative './persistTeam.rb'
require_relative './persistSeasonTeam.rb'
require_relative './loadPage.rb'
require_relative './parseBios.rb'
require_relative './persistBios.rb'
require_relative './persistRoster.rb'

require_relative './parseStats.rb'
require_relative './persistStats.rb'

require_relative './parseAdvanceds.rb'
require_relative './persistAdvanceds.rb'

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

  # XXXXXXXXXXXXXXXXX PARSE PLAYER ADVANCED STATS XXXXXXXXXXXXXXXXX

    player_advanceds = parseAdvanceds(attrs, htmlPage)

  # XXXXXXXXXXXXXXXXX PERSIST PLAYER ADVANCED STATS XXXXXXXXXXXXXXXXX

    persistAdvanceds(attrs, player_advanceds)

    # parse_salaries
    # persist_salaries


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
