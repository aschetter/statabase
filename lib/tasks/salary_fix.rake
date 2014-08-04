namespace :db do
  task :salary_fix => :environment do

    puts ""
    puts "NORMALIZING SALARY INFO:"
    puts ""

    nil_salaries = Player.where(salary: nil)
    nil_salaries.each do |player|
      puts "#{player.name}"
      player_teams = Player.where(br_id: player.br_id)
      total_salary = 0
      total_games = 0
      player_teams.each do |player_team|

        if player_team.stat.nil?
          "NO STAT SHEET FOR THIS PLAYER"
        else
          total_salary += player_team.salary.to_i
          total_games += player_team.stat.gp.to_i
          puts "#{player_team.team.br_id}: gp: #{player_team.stat.gp.to_i}, salary: #{player_team.salary.to_i}"
        end
      end
      puts ""
      puts "TOTAL GP: #{total_games}"
      puts "TOTAL SALARY: #{total_salary}"
      puts ""
      player_teams.each do |player_team|
        if total_salary == 0
          puts "#{player_team.team.br_id}: NO SALARY LISTED"
          puts ""
        else
          gp_percentage = player_team.stat.gp.to_f / total_games
          gp_percentage = ( gp_percentage * 100 ).round / 100.0

          player_team.salary = gp_percentage * total_salary
          player_team.save
          puts "#{player_team.team.br_id}"
          puts "SALARY: #{player_team.salary}"
          puts "GAMES: #{player_team.stat.gp}"
          puts "ALL GAMES: #{total_games}"
          puts "GP PERCENTAGE: #{gp_percentage}"
          puts ""
        end
      end
    end
  end
end
