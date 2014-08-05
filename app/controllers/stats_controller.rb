class StatsController < ApplicationController
  before_action :set_season
  before_action :set_team
  before_action :set_player
  before_action :set_stat

  def index
    if @stat
      render json: @stat
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show
    if @stat
      render json: @stat
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

  def set_player
    if !@season
      set_season
    end
    if !@team
      set_team
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
        @player = @team.players.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @player = nil
      end
    end
  end

  def set_stat
    if !@season
      set_season
    end
    if !@team
      set_team
    end
    if !@player
      set_player
    end
    begin
      @stat = @player.stat
    rescue ActiveRecord::RecordNotFound => e
      @stat = nil
    end
  end
end
