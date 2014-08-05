class TeamsController < ApplicationController
  before_action :set_season
  before_action :set_team

  def index
    if @season
      @teams = @season.teams.all
      render json: @teams
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show
    if @team
      render json: @team
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
      @team = Season.find(params[:season_id]).teams.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @team = nil
    end
  end
end
