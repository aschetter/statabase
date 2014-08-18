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

    # br_id: unique team ID in the online database (0-29)
    br_id = 25

    attrs[:@db_team] = persistTeam(br_id)

  # XXXXXXXXXXXXXXXXX SEASON_TEAM XXXXXXXXXXXXXXXXX

    persistSeasonTeam(attrs)

  # XXXXXXXXXXXXXXXXX LOAD HTML PAGE XXXXXXXXXXXXXXXXX

    htmlPage = LoadPage(attrs)

  # XXXXXXXXXXXXXXXXX PLAYER BIOS XXXXXXXXXXXXXXXXX

    @players = {
      added: 0,
      already_in_db: 0
    }

    player_bios = parsePlayers(htmlPage)
    team_players = persistPlayers(player_bios)

  # XXXXXXXXXXXXXXXXX TEAM ROSTER XXXXXXXXXXXXXXXXX

    persistRoster(attrs, team_players)

  # XXXXXXXXXXXXXXXXX PLAYER STATS XXXXXXXXXXXXXXXXX

    @statlines = {
      added: 0
    }

    player_statlines = parseStats(attrs, htmlPage)
    persistStats(attrs, player_statlines)

  # XXXXXXXXXXXXXXXXX PLAYER ADVANCED STATS XXXXXXXXXXXXXXXXX

    @advanceds = {
      added: 0
    }

    player_advanceds = parseAdvanceds(attrs, htmlPage)
    persistAdvanceds(attrs, player_advanceds)

  # XXXXXXXXXXXXXXXXX PLAYER SALARY INFO XXXXXXXXXXXXXXXXX

    @salaries = {
      added: 0,
      updated: 0
    }

    player_salaries = parseSalaries(htmlPage)
    persistSalaries(attrs, player_salaries)

    puts ""
    puts "PLAYERS BASIC INFO ADDED: #{@players[:added]}"
    puts "SEASON TOTALS ADDED: #{@statlines[:added]}"
    puts "ADVANCED STATS ADDED: #{@advanceds[:added]}"
    puts "JUST PLAYER SALARY ADDED: #{@salaries[:added]}"
    puts "PLAYERS UPDATED WITH SALARY INFO: #{@salaries[:updated]}"
  end
end
