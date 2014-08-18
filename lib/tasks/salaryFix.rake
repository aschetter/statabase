require_relative './findNilSalaries.rb'
require_relative './matchPlayer.rb'
require_relative './totalSeasonSalary.rb'

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


    def calculateGamePercentage(player_salaries)

      player_salaries.each do |player|

        puts player[:name]

        player[:memberships].each do |membership|
          team_games = membership[:gp].to_f
          season_games = player[:total][:totalGP]

          gp_percentage = team_games / season_games
          gp_percentage = ( gp_percentage * 100 ).round / 100.0
        end
      end
    end

    calculateGamePercentage(player_salaries)

      #     player_team.salary = gp_percentage * total_salary
      #     player_team.save
      #     puts "#{player_team.team.br_id}"
      #     puts "SALARY: #{player_team.salary}"
      #     puts "GAMES: #{player_team.stat.gp}"
      #     puts "ALL GAMES: #{total_games}"
      #     puts "GP PERCENTAGE: #{gp_percentage}"
      #     puts ""
      #   end
      # end






  end
end
