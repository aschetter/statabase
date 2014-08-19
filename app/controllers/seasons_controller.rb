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
        entry = { name: player.name, team: team.br_id, ws: win_shares }
        response << entry
      else
        entry = { name: player.name, team: team.br_id, ws: 0 }
        response << entry
      end

    end

    @win_shares = response.sort_by { |player| player[:ws].to_f }.reverse
    render json: @win_shares
  end

  def show_cost_per_win_share
    response = []

    memberships = Membership.where(season_id: @season.id)

    memberships.each do |membership|
      player = Player.find(membership.player_id)
      team = Team.find(membership.team_id)
      adv = Adv.find_by(membership_id: membership.id)

      if adv
        win_shares = adv[:ws]
        salary = membership[:salary]

        if salary > 0
          cpws = win_shares / salary
          cpws *= 1000000
          cpws = (cpws * 100).round / 100.0

          entry = { name: player.name, team: team.br_id, salary: salary, ws: win_shares, cpws: cpws }
          response << entry
        end
      else
        entry = { name: player.name, team: team.br_id, salary: salary, ws: 0, cpws: 0 }
        response << entry
      end
    end

    @cpws = response.sort_by { |player| player[:cpws].to_f }.reverse
    render json: @cpws
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
