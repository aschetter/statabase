namespace :db do
  task :salary_fix => :environment do

    puts "NORMALIZING SALARY INFO:"
    puts ""

    nil_salaries = Player.where(salary: nil)
    nil_salaries.each do |player|
      puts "#{player.name}"
      player_teams = Player.where(br_id: player.br_id)
      total_salary = 0
      total_games= 0
      player_teams.each do |player_team|
        total_salary += player_team.salary.to_i
        total_games += player_team.stat.gp.to_i
        puts "#{player_team.team.br_id}"
        puts "gp: #{player_team.stat.gp}, salary: #{player_team.salary}"
      end
      puts ""
      puts "gp: #{total_games}, salary: #{total_salary}"
      player_teams.each do |player_team|
        if total_salary == 0
          puts "#{player_team.name} HAS NO SALARY LISTED"
          puts ""
        else
          gp_percentage = player_team.stat.gp.to_f / total_games
          gp_percentage = ( gp_percentage * 100 ).round / 100.0

          player_team.salary = gp_percentage * total_salary
          player_team.save
          puts "GAMES ON THIS TEAM #{player_team.stat.gp}"
          puts "SALARY FOR THIS TEAM: #{player_team.salary}"
          puts "TOTAL GAMES: #{total_games}"
          puts "GP PERCENTAGE: #{gp_percentage}"
          puts ""
        end
      end
    end
  end
end
