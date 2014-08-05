class PlayersController < ApplicationController
  before_action :set_season
  before_action :set_team
  before_action :set_player

  def index
    if @season && @team
      @players = @team.players.all
      render json: @players
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show
    if @player
      render json: @player
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  private

  def set_season
    begin
      @season = Season.find(params[:season_id])
    rescue ActiveRecord::RecordNotFound => e
      @season = nil
    end
  end

  def set_team
    if !@season
      set_season
    end
    begin
      @team = @season.teams.find(params[:team_id])
    rescue ActiveRecord::RecordNotFound => e
      @team = nil
    end
  end

  def set_player
    if !@season
      set_season
    end
    if !@team
      set_team
    end
    begin
      @player = @team.players.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @player = nil
    end
  end
end
