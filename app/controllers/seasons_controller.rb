class SeasonsController < ApplicationController
  before_action :set_season

  def index
    @seasons = Season.all
    render json: @seasons
  end

  def show
    if @season
      render json: @season
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_salaries
    @response = []

    memberships = Membership.where(season_id: @season.id)

    memberships.each do |membership|
      player = Player.find(membership.player_id)
      team = Team.find(membership.team_id)
      entry = { name: player.name, team: team.br_id, salary: membership.salary }

      @response << entry
    end

    render json: @response
  end














  private

  def set_season
    season_id = params[:id].to_i
    if season_id > 1900
      begin
        @season = Season.find_by(year: season_id)
      rescue ActiveRecord::RecordNotFound => e
        @season = nil
      end
    else
      begin
        @season = Season.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @season = nil
      end
    end
  end
end
