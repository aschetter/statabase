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
      @player = @team.players.find(params[:player_id])
      puts "THE PLAYER IS #{@player}"
    rescue ActiveRecord::RecordNotFound => e
      @player = nil
    end
  end

  def set_stat
    if !@season
      set_season
    end
    if !@team
      set_team
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
