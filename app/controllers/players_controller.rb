class PlayersController < ApplicationController
  before_action :set_season
  before_action :team_is_number?
  before_action :set_team
  before_action :player_is_number?
  before_action :set_player
  before_action :set_membership

  def index
    return render_404 if @team.nil?

    @players = @team.players.all
    render json: @players
  end

  def show
    return render_404 if @player.nil?
    render json: @player
  end

  def stats
    return render_404 if @membership.nil?

    stat = Stat.find_by(membership_id: @membership.id)
    return render_404 if stat.nil?

    @stats = stat
    render json: @stats
  end

  def advanced_stats
    return render_404 if @membership.nil?

    adv = Adv.find_by(membership_id: @membership.id)
    return render_404 if adv.nil?

    @advs = adv
    render json: @advs
  end

  def salaries
    return render_404 if @membership.nil?

    @salary = { name: @player.name, salary: @membership.salary }
    render json: @salary
  end

  def win_shares
    return render_404 if @membership.nil?

    adv = Adv.find_by(membership_id: @membership.id)
    return render_404 if adv.nil?

    win_shares = adv[:ws]
    @win_shares = { name: @player.name, ws: win_shares }

    render json: @win_shares
  end

  def win_shares_index
    return render_404 if @membership.nil?

    adv = Adv.find_by(membership_id: @membership.id)
    salary = @membership[:salary].to_i

    if adv && salary > 0
      win_shares = adv[:ws]

      ws_index = win_shares / salary
      ws_index *= 1000000
      ws_index = (ws_index * 100).round / 100.0

      @ws_index = { name: @player.name, salary: salary, ws: win_shares, ws_index: ws_index }
    else
      return render_404
    end
    render json: @ws_index
  end

  def cost_per_point
    return render_404 if @membership.nil?

    stat = Stat.find_by(membership_id: @membership.id)
    salary = @membership[:salary].to_i

    if stat && salary > 0
      points = stat[:pts]

      if points > 0
        cpp = salary / points
        @cpp = { name: @player.name, salary: salary, pts: points, cpp: cpp }
      else
        @cpp = { name: @player.name, salary: salary, pts: 0, cpp: 0 }
      end
    else
      @cpp = { name: @player.name, salary: salary, pts: 0, cpp: 0 }
    end

    render json: @cpp
  end

  def cost_per_assist
    return render_404 if @membership.nil?

    stat = Stat.find_by(membership_id: @membership.id)
    salary = @membership[:salary].to_i

    if stat && salary > 0
      assists = stat[:ast]

      if assists > 0
        cpa = salary / assists
        @cpa = { name: @player.name, salary: salary, ast: assists, cpa: cpa }
      else
        @cpa = { name: @player.name, salary: salary, ast: 0, cpa: 0 }
      end
    else
      @cpa = { name: @player.name, salary: salary, ast: 0, cpa: 0 }
    end

    render json: @cpa
  end

  def cost_per_rebound
    return render_404 if @membership.nil?

    stat = Stat.find_by(membership_id: @membership.id)
    salary = @membership[:salary].to_i

    if stat && salary > 0
      rebounds = stat[:trb]

      if rebounds > 0
        cpr = salary / rebounds
        @cpr = { name: @player.name, salary: salary, trb: rebounds, cpr: cpr }
      else
        @cpr = { name: @player.name, salary: salary, trb: 0, cpr: 0 }
      end
    else
      @cpr = { name: @player.name, salary: salary, trb: 0, cpr: 0 }
    end

    render json: @cpr
  end

  def cost_per_block
    return render_404 if @membership.nil?

    stat = Stat.find_by(membership_id: @membership.id)
    salary = @membership[:salary].to_i

    if stat && salary > 0
      blocks = stat[:blk]

      if blocks > 0
        cpb = salary / blocks
        @cpb = { name: @player.name, salary: salary, blk: blocks, cpb: cpb }
      else
        @cpb = { name: @player.name, salary: salary, blk: 0, cpb: 0 }
      end
    else
      @cpb = { name: @player.name, salary: salary, blk: 0, cpb: 0 }
    end

    render json: @cpb
  end

  def cost_per_minute
    return render_404 if @membership.nil?

    stat = Stat.find_by(membership_id: @membership.id)
    salary = @membership[:salary].to_i

    if stat && salary > 0
      minutes = stat[:min]

      if minutes > 0
        cpm = salary / minutes
        @cpm = { name: @player.name, salary: salary, min: minutes, cpm: cpm }
      else
        @cpm = { name: @player.name, salary: salary, min: 0, cpm: 0 }
      end
    else
      @cpm = { name: @player.name, salary: salary, min: 0, cpm: 0 }
    end

    render json: @cpm
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

  def team_is_number?
    params[:team_id].to_f.to_s == params[:team_id].to_s || params[:team_id].to_i.to_s == params[:team_id].to_s
  end

  def set_team
    if !@season
      set_season
    end

    if team_is_number?
      begin
        @team = @season.teams.find(params[:team_id])
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    else
      begin
        @team = @season.teams.find_by(br_id: params[:team_id].upcase)
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    end
  end

  def player_is_number?
    params[:id].to_f.to_s == params[:id].to_s || params[:id].to_i.to_s == params[:id].to_s
  end

  def set_player
    if !@season
      set_season
    end
    if !@team
      set_team
    end

    if player_is_number?
      begin
        @player = @team.players.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @player = nil
      end
    else
      begin
        @player = @team.players.find_by(name: params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @player = nil
      end
    end
  end

  def set_membership
    if !@season
      set_season
    end
    if !@team
      set_team
    end
    if !@player
      set_player
    end
    begin
      @membership = Membership.find_by(season_id: @season.id, team_id: @team.id)
    rescue ActiveRecord::RecordNotFound => e
      @membership = nil
    end
  end
end
