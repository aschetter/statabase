require_relative './findNilSalaries.rb'
require_relative './matchPlayer.rb'
require_relative './totalSeasonSalary.rb'

namespace :db do
  task :salaryFix => :environment do

    puts ""
    puts "NORMALIZING SALARY INFO:"
    puts ""

########## FIND NIL SALARIES ########

    memberships = findNilSalaries

######## FIND MATCHING PLAYERS FOR THE SAME SEASON

    players_memberships = matchPlayer(memberships)

####### TOTAL THE PLAYERS' SEASON SALARY AND GAMES

    totalSeasonSalary(players_memberships)

      
    #   player_teams.each do |player_team|
    #     if total_salary == 0
    #       puts "#{player_team.team.br_id}: NO SALARY LISTED"
    #       puts ""
    #     else
    #       gp_percentage = player_team.stat.gp.to_f / total_games
    #       gp_percentage = ( gp_percentage * 100 ).round / 100.0

    #       player_team.salary = gp_percentage * total_salary
    #       player_team.save
    #       puts "#{player_team.team.br_id}"
    #       puts "SALARY: #{player_team.salary}"
    #       puts "GAMES: #{player_team.stat.gp}"
    #       puts "ALL GAMES: #{total_games}"
    #       puts "GP PERCENTAGE: #{gp_percentage}"
    #       puts ""
    #     end
    #   end
  end
end
