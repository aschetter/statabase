require_relative './populate/persistSeason.rb'
require_relative './populate/persistTeam.rb'
require_relative './populate/persistSeasonTeam.rb'

require_relative './populate/loadPage.rb'

require_relative './populate/parsePlayers.rb'
require_relative './populate/persistPlayers.rb'

require_relative './populate/persistRoster.rb'

require_relative './populate/parseStats.rb'
require_relative './populate/persistStats.rb'

require_relative './populate/parseAdvanceds.rb'
require_relative './populate/persistAdvanceds.rb'

require_relative './populate/parseSalaries.rb'
require_relative './populate/persistSalaries.rb'

require_relative './populate/displayResults.rb'

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    attrs = {}

  # XXXXXXXXXXXXXXXXX SEASON XXXXXXXXXXXXXXXXX

    attrs[:@db_season] = BBall.persistSeason(2014)

  # XXXXXXXXXXXXXXXXX TEAM XXXXXXXXXXXXXXXXX

    $team_stats = {
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
    br_id = 27

    attrs[:@db_team] = BBall.persistTeam(br_id)

  # XXXXXXXXXXXXXXXXX SEASON_TEAM XXXXXXXXXXXXXXXXX

    BBall.persistSeasonTeam(attrs)

  # XXXXXXXXXXXXXXXXX LOAD HTML PAGE XXXXXXXXXXXXXXXXX

    htmlPage = BBall.loadPage(attrs)

  # XXXXXXXXXXXXXXXXX PLAYER BIOS XXXXXXXXXXXXXXXXX

    player_bios = BBall.parsePlayers(htmlPage)
    team_players = BBall.persistPlayers(player_bios)

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
