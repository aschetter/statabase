require_relative './salaryFix/findNilSalaries.rb'
require_relative './salaryFix/matchPlayer.rb'
require_relative './salaryFix/totalSeasonSalary.rb'
require_relative './salaryFix/calculateGamePercentages.rb'
require_relative './salaryFix/adjustPlayerSalaries.rb'

namespace :db do
  task :salaryFix => :environment do

    puts ""
    puts "NORMALIZING SALARY INFO:"
    puts ""

####### FIND NIL SALARIES ########

    memberships = BBall.findNilSalaries

####### FIND MATCHING PLAYERS FOR THE SAME SEASON

    players_memberships = BBall.matchPlayer(memberships)

####### TOTAL PLAYERS' SEASON SALARY AND GAMES

    player_salaries = BBall.totalSeasonSalary(players_memberships)

####### CALCULATE PLAYERS' GAMES PLAYED PERCENTAGE PER TEAM

    percentages = BBall.calculateGamePercentages(player_salaries)

####### ADJUST PLAYERS' SALARIES BASED ON GAMES PLAYED PERCENTAGES

    BBall.adjustPlayerSalaries(percentages)

  end
end
