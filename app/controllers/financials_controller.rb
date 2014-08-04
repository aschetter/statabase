class FinancialsController < ApplicationController

  def index
    @team_stats = {
      salaries: {
                  total: 0,
                  players: 0,
                  average: 0
      },
      win_shares: {
                    total: 0,
                    players: 0,
                    average: 0
      },
      roi: {
              average: 0
      }   
    }

    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        if player.salary.nil?
          puts "THIS PLAYER DOESN'T HAVE A SALARY UNDER THIS TEAM"
          salary = Player.find_by(br_id: player.br_id)
        else
          @team_stats[:salaries][:total] += player.salary.to_i
          @team_stats[:salaries][:players] += 1
        end

        adv = player.adv
        if adv.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.adv.ws
          ws = ( ws * 100 ).round / 100.0
          @team_stats[:win_shares][:total] += ws
          @team_stats[:win_shares][:players] += 1
        end
      end
    end

    salaries = @team_stats[:salaries][:total]
    player_salaries = @team_stats[:salaries][:players]

    @team_stats[:salaries][:average] = salaries / player_salaries

    win_shares = @team_stats[:win_shares][:total]
    win_shares = (win_shares * 100).round / 100.0
    @team_stats[:win_shares][:total] = win_shares

    player_win_shares = @team_stats[:win_shares][:players]

    average = win_shares / player_win_shares
    average = (average * 100).round / 100.0

    @team_stats[:win_shares][:average] = average

    adjusted_salary = @team_stats[:salaries][:average] / 10000000.0
    win_shares_average = @team_stats[:win_shares][:average]
    roi_average = win_shares_average / adjusted_salary
    roi_average = (roi_average * 100).round / 100.0

    @team_stats[:roi][:average] = roi_average

    render json: @team_stats
  end

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
        adv = player.adv
        if adv.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.adv.ws
          @total_win_shares += ws
        end
      end
    end

    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        adv = player.adv
        if adv.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.adv.ws.to_f
          percent = ws / @total_win_shares
          percent *= 100
          percent = percent.to_i 
          response << { name: player.name, team: team.br_id, ws: ws, percent: percent}
        end
      end
    end

    @win_shares = response.sort_by { |player| player[:percent].to_i }.reverse
    render json: @win_shares
  end

  def roi
    @total_win_shares = 0
    @total_salaries = 0
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        adv = player.adv
        if adv.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.adv.ws
          @total_win_shares += ws

          salary = player.salary
          @total_salaries += salary.to_i
        end
      end
    end

    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        adv = player.adv
        if adv.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.adv.ws.to_f
          percent = ws / @total_win_shares

          salary = player.salary.to_f
          salary = salary / @total_salaries

          if salary > 0
            roi = percent / salary

            response << { name: player.name, salary: salary, percent: percent, team: team.br_id, roi: roi}
          else
            response << { name: player.name, team: team.br_id, roi: 0}
          end
        end
      end
    end

    @roi = response.sort_by { |player| player[:roi].to_i }.reverse
    render json: @roi
  end
end
