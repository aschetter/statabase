class TeamsController < ApplicationController

  def index
    season_id = params[:id].to_i

    if season_id > 1900
      @season = Season.find_by(year: params[:id])
    else
      @season = Season.find(params[:id])
    end

    if @season
      @teams = []

      season_teams = SeasonTeam.where(season_id: @season.id)

      season_teams.each do |team|
        @teams << Team.find(team.team_id)
      end

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
end
