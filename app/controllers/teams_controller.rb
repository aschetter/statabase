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
    team_id = params[:id].to_i
    if team_id < 1
      begin
        @team = @season.teams.find_by(br_id: params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    else
      begin
        @team = @season.teams.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    end
  end
end
