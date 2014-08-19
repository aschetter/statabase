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

  def show_stats
    if @season
      response = []

      memberships = Membership.where(season_id: @season.id, team_id: @team.id)

      memberships.each do |membership|
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



















  def show_salaries
    if @team

      response = []
      
      memberships = @team.memberships.all

      memberships.each do |membership|
        player = Player.find(membership.player_id)
        entry = { name: player.name, salary: membership.salary }

        response << entry
      end

      @salaries = response.sort_by { |player| player[:salary].to_f }.reverse
      render json: @salaries
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_win_shares
    if @team
      response = []

      memberships = Membership.where(season_id: @season.id, team_id: @team.id)

      memberships.each do |membership|
        player = Player.find(membership.player_id)
        adv = Adv.find_by(membership_id: membership.id)

        if adv
          win_shares = adv[:ws]
          entry = { name: player.name, ws: win_shares }
          response << entry
        else
          entry = { name: player.name, ws: 0 }
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
    if @team
      response = []

      memberships = Membership.where(season_id: @season.id, team_id: @team.id)

      memberships.each do |membership|
        player = Player.find(membership.player_id)
        adv = Adv.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if adv && salary > 0
          win_shares = adv[:ws]

          ws_index = win_shares / salary
          ws_index *= 1000000
          ws_index = (ws_index * 100).round / 100.0

          entry = { name: player.name, salary: salary, ws: win_shares, ws_index: ws_index }
          response << entry
        else
          entry = { name: player.name, salary: salary, ws: 0, ws_index: 0 }
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
    if @team
      response = []

      memberships = Membership.where(season_id: @season.id, team_id: @team.id)

      memberships.each do |membership|
        player = Player.find(membership.player_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          points = stat[:pts]

          if points > 0
            cpp = salary / points
            entry = { name: player.name, salary: salary, pts: points, cpp: cpp }
          else
            entry = { name: player.name, salary: salary, pts: 0, cpp: 0 }
          end
          response << entry
        else
          entry = { name: player.name, salary: salary, pts: 0, cpp: 0 }
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
    if @team
      response = []

      memberships = Membership.where(season_id: @season.id, team_id: @team.id)

      memberships.each do |membership|
        player = Player.find(membership.player_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          assists = stat[:ast]

          if assists > 0
            cpa = salary / assists
            entry = { name: player.name, salary: salary, ast: assists, cpa: cpa }
          else
            entry = { name: player.name, salary: salary, ast: 0, cpa: 0 }
          end
          response << entry
        else
          entry = { name: player.name, salary: salary, ast: 0, cpa: 0 }
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
    if @team
      response = []

      memberships = Membership.where(season_id: @season.id, team_id: @team.id)

      memberships.each do |membership|
        player = Player.find(membership.player_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          rebounds = stat[:trb]

          if rebounds > 0
            cpr = salary / rebounds
            entry = { name: player.name, salary: salary, trb: rebounds, cpr: cpr }
          else
            entry = { name: player.name, salary: salary, trb: 0, cpr: 0 }
          end
            response << entry
        else
          entry = { name: player.name, salary: salary, trb: 0, cpr: 0 }
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
    if @team
      response = []

      memberships = Membership.where(season_id: @season.id, team_id: @team.id)

      memberships.each do |membership|
        player = Player.find(membership.player_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          blocks = stat[:blk]

          if blocks > 0
            cpb = salary / blocks
            entry = { name: player.name, salary: salary, blk: blocks, cpb: cpb }
          else
            entry = { name: player.name, salary: salary, blk: 0, cpb: 0 }
          end
            response << entry
        else
          entry = { name: player.name, salary: salary, blk: 0, cpb: 0 }
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
    if @team
      response = []

      memberships = Membership.where(season_id: @season.id, team_id: @team.id)

      memberships.each do |membership|
        player = Player.find(membership.player_id)
        team = Team.find(membership.team_id)
        stat = Stat.find_by(membership_id: membership.id)
        salary = membership[:salary].to_i

        if stat && salary > 0
          minutes = stat[:min]

          if minutes > 0
            cpm = salary / minutes
            entry = { name: player.name, salary: salary, min: minutes, cpm: cpm }
          else
            entry = { name: player.name, salary: salary, min: 0, cpm: 0 }
          end
            response << entry
        else
          entry = { name: player.name, salary: salary, min: 0, cpm: 0 }
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
        @team = @season.teams.find_by(br_id: params[:id].upcase)
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
