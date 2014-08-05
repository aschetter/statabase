class CostPerReboundsController < ApplicationController
  before_action :set_season
  before_action :set_team
  before_action :set_player

  def index
    if @season && !@team && @in_db
      response = Array.new
      players = @season.teams.map do |team| 
        team.players.map do |player|
          stat = player.stat

          if stat
            trb = player.stat.trb.to_i
            salary = player.salary.to_i

            if trb > 0
              cpr = salary / trb
              response << { name: player.name, salary: salary, team: team.br_id, trb: trb, cpr: cpr }
            else
              response << { name: player.name, team: team.br_id, cpr: "null" }
            end
          end
        end
      end

      @cpr = response.sort_by { |player| player[:cpr].to_f }.reverse
      render json: @cpr

    elsif @season && @team && !@player
      response = Array.new
      cpr = @team.players.all.map do |player|
        stat = player.stat

        if stat
          trb = player.stat.trb.to_i
          salary = player.salary.to_i

          if trb > 0
            cpr = salary / trb
            response << { name: player.name, salary: salary, trb: trb, cpr: cpr }
          else
            response << { name: player.name, cpr: "null" }
          end
        end
      end
      @cpr = response.sort_by { |player| player[:cpr].to_f }.reverse
      render json: @cpr
    elsif @player
      stat = @player.stat

      if stat
        trb = @player.stat.trb.to_i
        salary = @player.salary.to_i

        if trb > 0
          cpr = salary / trb
          @cpr = { name: @player.name, salary: salary, trb: trb, cpr: cpr }
        else
          @cpr = { name: @player.name, cpr: "null" }
        end
      end
      render json: @cpr
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  private

  def set_season
    season_id = params[:season_id].to_i
    if season_id > 1900
      begin
        @season = Season.find_by(year: season_id)
      rescue ActiveRecord::RecordNotFound => e
        @season = nil
      end
    else
      begin
        @season = Season.find(params[:season_id])
      rescue ActiveRecord::RecordNotFound => e
        @season = nil
      end
    end
  end

  def set_team
    if !@season
      set_season
    end

    total = @season.teams.length
    if total > params[:team_id].to_i
      @in_db = true
    end

    team_id = params[:team_id].to_i
    if team_id < 1
      begin
        @team = @season.teams.find_by(br_id: params[:team_id])
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    else
      begin
        @team = @season.teams.find(params[:team_id])
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    end
  end

  def set_player
    if !@season
      set_season
    end
    if !@team
      set_team
    end
    if !@team
      return
    end
    
    player_id = params[:player_id].to_i
    if player_id < 1
      begin
        @player = @team.players.find_by(name: params[:player_id])
      rescue ActiveRecord::RecordNotFound => e
        @player = nil
      end
    else
      begin
        @player = @team.players.find(params[:player_id])
      rescue ActiveRecord::RecordNotFound => e
        @player = nil
      end
    end
  end
end
