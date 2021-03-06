class TeamsController < ApplicationController
  before_action :set_season
  before_action :team_is_number?
  before_action :set_team
  before_action :set_memberships

  def index
    return render_404 if @season.nil?
    @teams = @season.teams.all

    render json: @teams
  end

  def show
    return render_404 if @team.nil?
    render json: @team
  end

  def stats
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
      stat = Stat.find_by(membership_id: membership.id)

      if stat
        membership = Membership.find(stat.membership_id)
        player = Player.find(membership.player_id)

        stat.player_name = player.name
        response << stat
      end
    end

    @stats = response.sort_by { |player| player[:pts].to_f }.reverse
    render json: @stats
  end

  def advanced_stats
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
      adv = Adv.find_by(membership_id: membership.id)

      if adv
        membership = Membership.find(adv.membership_id)
        player = Player.find(membership.player_id)

        adv.player_name = player.name
        response << adv
      end
    end

    @advs = response.sort_by { |player| player[:ws].to_f }.reverse
    render json: @advs
  end

  def salaries
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
      player = Player.find(membership.player_id)
      entry = { name: player.name, salary: membership.salary }

      response << entry
    end

    @salaries = response.sort_by { |player| player[:salary].to_f }.reverse
    render json: @salaries
  end

  def win_shares
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
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
  end

  def win_shares_index
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
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
  end

  def cost_per_point
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
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
  end

  def cost_per_assist
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
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
  end

  def cost_per_rebound
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
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
  end

  def cost_per_block
    return render_404 if @memberships.nil?
    response = []

    @memberships.each do |membership|
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
  end

  def cost_per_minute
    return render_404 if @memberships.nil?
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
    elsif season_id
      begin
        @season = Season.find(season_id)
      rescue ActiveRecord::RecordNotFound => e
        @season = nil
      end
    else
      @season = nil
    end
  end

  def team_is_number?
    params[:id].to_f.to_s == params[:id].to_s || params[:id].to_i.to_s == params[:id].to_s
  end

  def set_team
    if !@season
      set_season
    end

    if team_is_number? && @season
      begin
        @team = @season.teams.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    elsif params[:id] && @season
      begin
        @team = @season.teams.find_by(br_id: params[:id].upcase)
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    else
      @team = nil
    end
  end

  def set_memberships
    if !@season
      set_season
    end
    if !@team
      set_team
    end
    if @team
      begin
        @memberships = Membership.where(season_id: @season.id, team_id: @team.id)
      rescue ActiveRecord::RecordNotFound => e
        @memberships = nil
      end
    end
  end
end
