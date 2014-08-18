require_relative './persistSeason.rb'
require_relative './persistTeam.rb'
require_relative './persistSeasonTeam.rb'

require_relative './loadPage.rb'

require_relative './parsePlayers.rb'
require_relative './persistPlayers.rb'

require_relative './persistRoster.rb'

require_relative './parseStats.rb'
require_relative './persistStats.rb'

require_relative './parseAdvanceds.rb'
require_relative './persistAdvanceds.rb'

require_relative './parseSalaries.rb'
require_relative './persistSalaries.rb'

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    attrs = {}

  # XXXXXXXXXXXXXXXXX SEASON XXXXXXXXXXXXXXXXX

    attrs[:@db_season] = persistSeason(2014)

  # XXXXXXXXXXXXXXXXX TEAM XXXXXXXXXXXXXXXXX

    @team_stats = {
      players: {
        added: 0,
        already_in_db: 0
      },
      statlines: {
        added: 0
      },
      advanceds: {
        added: 0
      },
      salaries: {
        added: 0,
        updated: 0
      }
    }

    # br_id: unique team ID in the online database (0-29)
    br_id = 25

    attrs[:@db_team] = persistTeam(br_id)

  # XXXXXXXXXXXXXXXXX SEASON_TEAM XXXXXXXXXXXXXXXXX

    persistSeasonTeam(attrs)

  # XXXXXXXXXXXXXXXXX LOAD HTML PAGE XXXXXXXXXXXXXXXXX

    htmlPage = LoadPage(attrs)

  # XXXXXXXXXXXXXXXXX PLAYER BIOS XXXXXXXXXXXXXXXXX


    player_bios = parsePlayers(htmlPage)
    team_players = persistPlayers(player_bios)

  # XXXXXXXXXXXXXXXXX TEAM ROSTER XXXXXXXXXXXXXXXXX

    persistRoster(attrs, team_players)

  # XXXXXXXXXXXXXXXXX PLAYER STATS XXXXXXXXXXXXXXXXX

    player_statlines = parseStats(attrs, htmlPage)
    persistStats(attrs, player_statlines)

  # XXXXXXXXXXXXXXXXX PLAYER ADVANCED STATS XXXXXXXXXXXXXXXXX

    player_advanceds = parseAdvanceds(attrs, htmlPage)
    persistAdvanceds(attrs, player_advanceds)

  # XXXXXXXXXXXXXXXXX PLAYER SALARY INFO XXXXXXXXXXXXXXXXX

    player_salaries = parseSalaries(htmlPage)
    persistSalaries(attrs, player_salaries)

    puts ""
    puts "TEAM: #{attrs[:@db_team].br_id}"
    puts "SEASON: #{attrs[:@db_season].year}"
    puts ""
    puts "PLAYERS ADDED TO DB: #{@team_stats[:players][:added]}"
    puts "PLAYERS ALREADY IN DB: #{@team_stats[:players][:already_in_db]}"
    puts "SEASON STATS ADDED: #{@team_stats[:statlines][:added]}"
    puts "ADVANCED STATS ADDED: #{@team_stats[:advanceds][:added]}"
    puts "JUST PLAYER SALARY ADDED: #{@team_stats[:salaries][:added]}"
    puts "PLAYERS UPDATED WITH SALARY INFO: #{@team_stats[:salaries][:updated]}"
  end
end
