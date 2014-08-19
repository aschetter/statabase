class SeasonsController < ApplicationController
  before_action :set_season
  before_action :set_memberships

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

  def stats
    if @memberships
      response = []

      @memberships.each do |membership|
        stat = Stat.find_by(membership_id: membership.id)

        if stat
          response << stat
        end
      end

      @stats = response.sort_by { |player| player[:pts].to_f }.reverse
      render json: @stats
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_advanceds
    if @memberships
      response = []

      @memberships.each do |membership|
        adv = Adv.find_by(membership_id: membership.id)

        if adv
          response << adv
        end
      end

      @advs = response.sort_by { |player| player[:ws].to_f }.reverse
      render json: @advs
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_salaries
    if @memberships
      response = []

      @memberships.each do |membership|
        player = Player.find(membership.player_id)
        team = Team.find(membership.team_id)

        entry = { name: player.name, team: team.br_id, salary: membership.salary }

        response << entry
      end

      @salaries = response.sort_by { |player| player[:salary].to_f }.reverse
      render json: @salaries
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_win_shares
    if @memberships
      response = []

      @memberships.each do |membership|
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
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_win_shares_index
    if @memberships
      response = []

      @memberships.each do |membership|
        player = Player.find(membership.player_id)
        team = Team.find(membership.team_id)
        adv = Adv.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if adv && salary > 0
          win_shares = adv[:ws]

          ws_index = win_shares / salary
          ws_index *= 1000000
          ws_index = (ws_index * 100).round / 100.0

          entry = { name: player.name, team: team.br_id, salary: salary, ws: win_shares, ws_index: ws_index }
          response << entry
        else
          entry = { name: player.name, team: team.br_id, salary: salary, ws: 0, ws_index: 0 }
          response << entry
        end
      end

      @ws_index = response.sort_by { |player| player[:ws_index].to_f }.reverse
      render json: @ws_index
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_cost_per_point
    if @memberships
      response = []

      @memberships.each do |membership|
        player = Player.find(membership.player_id)
        team = Team.find(membership.team_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          points = stat[:pts]

          if points > 0
            cpp = salary / points
            entry = { name: player.name, team: team.br_id, salary: salary, pts: points, cpp: cpp }
          else
            entry = { name: player.name, team: team.br_id, salary: salary, pts: 0, cpp: 0 }
          end
          response << entry
        else
          entry = { name: player.name, team: team.br_id, salary: salary, pts: 0, cpp: 0 }
          response << entry
        end
      end

      @cpp = response.sort_by { |player| player[:cpp].to_f }.reverse
      render json: @cpp
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_cost_per_assist
    if @memberships
      response = []

      @memberships.each do |membership|
        player = Player.find(membership.player_id)
        team = Team.find(membership.team_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          assists = stat[:ast]

          if assists > 0
            cpa = salary / assists
            entry = { name: player.name, team: team.br_id, salary: salary, ast: assists, cpa: cpa }
          else
            entry = { name: player.name, team: team.br_id, salary: salary, ast: 0, cpa: 0 }
          end
          response << entry
        else
          entry = { name: player.name, team: team.br_id, salary: salary, ast: 0, cpa: 0 }
          response << entry
        end
      end

      @cpa = response.sort_by { |player| player[:cpa].to_f }.reverse
      render json: @cpa
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_cost_per_rebound
    if @memberships
      response = []

      @memberships.each do |membership|
        player = Player.find(membership.player_id)
        team = Team.find(membership.team_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          rebounds = stat[:trb]

          if rebounds > 0
            cpr = salary / rebounds
            entry = { name: player.name, team: team.br_id, salary: salary, trb: rebounds, cpr: cpr }
          else
            entry = { name: player.name, team: team.br_id, salary: salary, trb: 0, cpr: 0 }
          end
            response << entry
        else
          entry = { name: player.name, team: team.br_id, salary: salary, trb: 0, cpr: 0 }
          response << entry
        end
      end

      @cpr = response.sort_by { |player| player[:cpr].to_f }.reverse
      render json: @cpr
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_cost_per_block
    if @memberships
      response = []

      @memberships.each do |membership|
        player = Player.find(membership.player_id)
        team = Team.find(membership.team_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          blocks = stat[:blk]

          if blocks > 0
            cpb = salary / blocks
            entry = { name: player.name, team: team.br_id, salary: salary, blk: blocks, cpb: cpb }
          else
            entry = { name: player.name, team: team.br_id, salary: salary, blk: 0, cpb: 0 }
          end
            response << entry
        else
          entry = { name: player.name, team: team.br_id, salary: salary, blk: 0, cpb: 0 }
          response << entry
        end
      end

      @cpb = response.sort_by { |player| player[:cpb].to_f }.reverse
      render json: @cpb
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_cost_per_minute
    if @memberships
      response = []

      @memberships.each do |membership|
        player = Player.find(membership.player_id)
        team = Team.find(membership.team_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          minutes = stat[:min]

          if minutes > 0
            cpm = salary / minutes
            entry = { name: player.name, team: team.br_id, salary: salary, min: minutes, cpm: cpm }
          else
            entry = { name: player.name, team: team.br_id, salary: salary, min: 0, cpm: 0 }
          end
            response << entry
        else
          entry = { name: player.name, team: team.br_id, salary: salary, min: 0, cpm: 0 }
          response << entry
        end
      end

      @cpm = response.sort_by { |player| player[:cpm].to_f }.reverse
      render json: @cpm
    else
      render status: 404, json: { status: :could_not_find }
    end
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

  def set_memberships
    if !@season
      set_season
    end

    if params[:id]
      begin
        @memberships = Membership.where(season_id: @season.id)
      rescue ActiveRecord::RecordNotFound => e
        @memberships = nil
      end
    end
  end
end
