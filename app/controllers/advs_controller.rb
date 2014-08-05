class AdvsController < ApplicationController
  before_action :set_season
  before_action :set_team
  before_action :set_player
  before_action :set_adv

  def index
    if @adv
      render json: @adv
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show
    if @adv
      render json: @adv
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

  def set_adv
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
      @adv = @player.adv
    rescue ActiveRecord::RecordNotFound => e
      @adv = nil
    end
  end
end

