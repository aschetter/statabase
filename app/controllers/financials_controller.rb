class FinancialsController < ApplicationController

  def salaries
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        response << { name: player.name, salary: player.salary }
      end
    end

    @salaries = response.sort_by { |player| player[:salary].to_i }.reverse
    render json: @salaries
  end

  def win_shares
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
        @counter = 0
      players.each do |player|
        advs = player.advs
        if advs.first.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.advs.first.ws
          puts player.name
          puts player.advs.first.ws
          @counter += 1
          puts @counter
          response << { name: player.name, ws: ws }
        end
      end
    end

    # @salaries = response.sort_by { |player| player[:salary].to_i }.reverse
    render json: response
  end
end
