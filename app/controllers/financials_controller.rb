class FinancialsController < ApplicationController

  def index
    @stats = {
      players: 0,
      salaries: {
                  total: 0,
                  average: 0
      },
      win_shares: {
                    total: 0,
                    average: 0
      },
      roi: {
              average: 0
      }   
    }

    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        adv = player.adv
        salary = player.salary

        if adv && salary.to_i > 0
          @stats[:salaries][:total] += player.salary

          ws = adv.ws
          ws = ( ws * 100 ).round / 100.0
          @stats[:win_shares][:total] += ws

          @stats[:players] += 1
        end
      end
    end

    players = @stats[:players]

    salaries = @stats[:salaries][:total]
    average_salary = salaries / players
    @stats[:salaries][:average] = average_salary

    win_shares = @stats[:win_shares][:total]
    average_win_shares = win_shares / players
    average_win_shares = (average_win_shares * 100).round / 100.0
    @stats[:win_shares][:average] = average_win_shares

    roi_average = average_win_shares / average_salary
    roi_average *= 1000000
    roi_average = (roi_average * 100).round / 100.0

    win_shares = (win_shares * 100).round / 100.0
    @stats[:win_shares][:total] = win_shares

    @stats[:roi][:average] = roi_average

    render json: @stats
  end

  def salaries
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        player_salary = player.salary.to_i
        response << { name: player.name, team: team.br_id, salary: player.salary }
      end
    end

    @salaries = response.sort_by { |player| player[:salary].to_i }.reverse
    render json: @salaries
  end

  def win_shares
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        adv = player.adv
        if adv.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          ws = player.adv.ws.to_f
          response << { name: player.name, team: team.br_id, ws: ws }
        end
      end
    end

    @win_shares = response.sort_by { |player| player[:ws] }.reverse
    render json: @win_shares
  end

def roi
  response = Array.new
  players = Season.find(1).teams.all.each do |team|
    players = team.players.all
    players.each do |player|
      adv = player.adv
      if adv.nil?
        puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
      else
        ws = player.adv.ws.to_f
        salary = player.salary.to_i

        if salary > 0
          roi = ws / salary
          roi *= 1000000
          roi = (roi * 100).round / 100.0
          response << { name: player.name, salary: salary, team: team.br_id, ws: ws, roi: roi}
        else
          response << { name: player.name, team: team.br_id, roi: 0 }
        end
      end
    end
  end

  @roi = response.sort_by { |player| player[:roi] }.reverse
  render json: @roi
  end

  def cost_per_point
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        stat = player.stat
        if stat.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          pts = player.stat.pts.to_i
          salary = player.salary.to_i

          if pts > 0
            cpp = salary / pts
            response << { name: player.name, salary: salary, team: team.br_id, pts: pts, cpp: cpp }
          else
            response << { name: player.name, team: team.br_id, cpp: 0 }
          end
        end
      end
    end

    @cpp = response.sort_by { |player| player[:cpp] }.reverse
    render json: @cpp
  end

  def cost_per_rebound
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        stat = player.stat
        if stat.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          trb = player.stat.trb.to_i
          salary = player.salary.to_i

          if trb > 0
            cpr = salary / trb
            response << { name: player.name, salary: salary, team: team.br_id, trb: trb, cpr: cpr }
          else
            response << { name: player.name, team: team.br_id, cpr: 0 }
          end
        end
      end
    end

    @cpr = response.sort_by { |player| player[:cpr] }.reverse
    render json: @cpr
  end

  def cost_per_block
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        stat = player.stat
        if stat.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          blk = player.stat.blk.to_i
          salary = player.salary.to_i

          if blk > 0
            cpb = salary / blk
            response << { name: player.name, salary: salary, team: team.br_id, blk: blk, cpb: cpb }
          else
            response << { name: player.name, team: team.br_id, cpb: 0 }
          end
        end
      end
    end

    @cpb = response.sort_by { |player| player[:cpb] }.reverse
    render json: @cpb
  end

  def cost_per_minute
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        stat = player.stat
        if stat.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          minutes = player.stat.min.to_i
          salary = player.salary.to_i

          if minutes > 0
            cpm = salary / minutes
            response << { name: player.name, salary: salary, team: team.br_id, minutes: minutes, cpm: cpm }
          else
            response << { name: player.name, team: team.br_id, cpm: 0 }
          end
        end
      end
    end

    @cpm = response.sort_by { |player| player[:cpm] }.reverse
    render json: @cpm
  end

  def cost_per_assist
    response = Array.new
    players = Season.find(1).teams.all.each do |team|
      players = team.players.all
      players.each do |player|
        stat = player.stat
        if stat.nil?
          puts "THIS PLAYER DOESN'T HAVE ADVANCED STATS FOR THE TEAM"
        else
          assists = player.stat.ast.to_i
          salary = player.salary.to_i

          if assists > 0
            cpa = salary / assists
            response << { name: player.name, salary: salary, team: team.br_id, assists: assists, cpa: cpa }
          else
            response << { name: player.name, team: team.br_id, cpa: 0 }
          end
        end
      end
    end

    @cpa = response.sort_by { |player| player[:cpa] }.reverse
    render json: @cpa
  end
end
