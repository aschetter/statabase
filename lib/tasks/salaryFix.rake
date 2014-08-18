require_relative './findNilSalaries.rb'
require_relative './matchPlayer.rb'
require_relative './totalSeasonSalary.rb'
require_relative './calculateGamePercentages.rb'
require_relative './adjustPlayerSalaries.rb'

namespace :db do
  task :salaryFix => :environment do

    puts ""
    puts "NORMALIZING SALARY INFO:"
    puts ""

####### FIND NIL SALARIES ########

    memberships = findNilSalaries

####### FIND MATCHING PLAYERS FOR THE SAME SEASON

    players_memberships = matchPlayer(memberships)

####### TOTAL PLAYERS' SEASON SALARY AND GAMES

    player_salaries = totalSeasonSalary(players_memberships)

####### CALCULATE PLAYERS' GAMES PLAYED PERCENTAGE PER TEAM

    percentages = calculateGamePercentages(player_salaries)

####### ADJUST PLAYERS' SALARIES BASED ON GAMES PLAYED PERCENTAGES

    adjustPlayerSalaries(percentages)

  end
end
