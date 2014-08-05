class WinSharesController < ApplicationController
  before_action :set_season
  before_action :set_team

  def index
    if @season && !@team
      response = Array.new
      players = @season.teams.map do |team| 
        team.players.map do |player|
          adv = player.adv

          if adv
            response << { name: player.name, team: team.br_id, ws: player.adv.ws }
          else
            response << { name: player.name, team: team.br_id, ws: "null" }
          end
        end
      end

      @ws = response.sort_by { |player| player[:ws].to_i }.reverse
      render json: @ws

    elsif @season && @team
      ws = @team.players.all.map do |player|
        {name: player.name, ws: player.adv.ws }
      end
      @ws = ws.sort_by { |player| player[:ws].to_i }.reverse
      render json: @ws
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
end
