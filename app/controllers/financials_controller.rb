class FinancialsController < ApplicationController

  def salaries
    @total_salaries = 0
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        @total_salaries += player.salary.to_i
      end
    end

    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        player_salary = player.salary.to_f
        percent = player_salary / @total_salaries
        percent *= 100
        percent = percent.to_i 
        response << { name: player.name, salary: player.salary, percent: percent,
        total_salaries: @total_salaries}
      end
    end

    @salaries = response.sort_by { |player| player[:salary].to_i }.reverse
    render json: @salaries
  end

  def win_shares
    @total_win_shares = 0
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        advs = player.advs
        if advs.first.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.advs.first.ws
          @total_win_shares += ws
        end
      end
    end

    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        advs = player.advs
        if advs.first.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.advs.first.ws
          percent = ws / @total_win_shares
          percent *= 100
          percent = percent.to_i 
          response << { name: player.name, team: team.br_id, ws: ws, percent: percent}
        end
      end
    end

    @win_shares = response.sort_by { |player| player[:ws].to_i }.reverse
    render json: @win_shares
  end
end
