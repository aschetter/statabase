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
    response = []

    memberships = Membership.where(season_id: @season.id)

    memberships.each do |membership|
      player = Player.find(membership.player_id)
      team = Team.find(membership.team_id)

      entry = { name: player.name, team: team.br_id, salary: membership.salary }

      response << entry
    end

    @salaries = response.sort_by { |player| player[:salary].to_f }.reverse
    render json: @salaries
  end

  def show_win_shares
    response = []

    memberships = Membership.where(season_id: @season.id)

    memberships.each do |membership|
      player = Player.find(membership.player_id)
      team = Team.find(membership.team_id)

      adv = Adv.find_by(membership_id: membership.id)

      if adv
        win_shares = adv[:ws]
        entry = { name: player.name, team: team.br_id, win_shares: win_shares }
        response << entry
      else
        entry = { name: player.name, team: team.br_id, win_shares: 0 }
        response << entry
      end

    end

    @win_shares = response.sort_by { |player| player[:win_shares].to_f }.reverse
    render json: @win_shares
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
