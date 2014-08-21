require_relative './populate/loadPage.rb'

require_relative './populate/parseData/parsePlayers.rb'
require_relative './populate/parseData/parseStats.rb'
require_relative './populate/parseData/parseAdvanceds.rb'
require_relative './populate/parseData/parseSalaries.rb'

require_relative './populate/persistData/persistSeason.rb'
require_relative './populate/persistData/persistTeam.rb'
require_relative './populate/persistData/persistSeasonTeam.rb'
require_relative './populate/persistData/persistPlayers.rb'
require_relative './populate/persistData/persistRoster.rb'
require_relative './populate/persistData/persistStats.rb'
require_relative './populate/persistData/persistAdvanceds.rb'
require_relative './populate/persistData/persistSalaries.rb'

require_relative './populate/displayResults.rb'

namespace :db do
  desc "Erase and fill database"
  task :populate, [:year, :br_id] => :environment do

    attrs = {
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

  # XXXXXXXXXXXXXXXXX SEASON XXXXXXXXXXXXXXXXX

    # year = ARGV[-2].to_i
    year = args.year

    attrs[:@db_season] = BBall.persistSeason(year)

  # XXXXXXXXXXXXXXXXX TEAM XXXXXXXXXXXXXXXXX


    # br_id: unique team ID in the online database (0-29)
    # br_id = ARGV[-1].to_i
    br_id = args.br_id

    attrs[:@db_team] = BBall.persistTeam(br_id)

  # XXXXXXXXXXXXXXXXX SEASON_TEAM XXXXXXXXXXXXXXXXX

    BBall.persistSeasonTeam(attrs)

  # XXXXXXXXXXXXXXXXX LOAD HTML PAGE XXXXXXXXXXXXXXXXX

    htmlPage = BBall.loadPage(attrs)

  # XXXXXXXXXXXXXXXXX PLAYER BIOS XXXXXXXXXXXXXXXXX

    player_bios = BBall.parsePlayers(htmlPage)
    team_players = BBall.persistPlayers(attrs, player_bios)

  # XXXXXXXXXXXXXXXXX TEAM ROSTER XXXXXXXXXXXXXXXXX

    BBall.persistRoster(attrs, team_players)

  # XXXXXXXXXXXXXXXXX PLAYER STATS XXXXXXXXXXXXXXXXX

    player_statlines = BBall.parseStats(attrs, htmlPage)
    BBall.persistStats(attrs, player_statlines)

  # XXXXXXXXXXXXXXXXX PLAYER ADVANCED STATS XXXXXXXXXXXXXXXXX

    player_advanceds = BBall.parseAdvanceds(attrs, htmlPage)
    BBall.persistAdvanceds(attrs, player_advanceds)

  # XXXXXXXXXXXXXXXXX PLAYER SALARY INFO XXXXXXXXXXXXXXXXX

    player_salaries = BBall.parseSalaries(htmlPage)
    BBall.persistSalaries(attrs, player_salaries)

  # XXXXXXXXXXXXXXXXX DISPLAY RESULTS XXXXXXXXXXXXXXXXX

    BBall.displayResults(attrs)

  end
end
