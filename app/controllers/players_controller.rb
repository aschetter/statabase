class PlayersController < ApplicationController
  before_action :set_season
  before_action :set_team
  before_action :set_player

  def index
    if @team

      @players = @team.players.all
      render json: @players
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show
    if @player
      render json: @player
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_salaries
    if @player

      membership = @player.memberships.find_by(season_id: @season.id, team_id: @team.id)
      @salary = { name: @player.name, salary: membership.salary }

      render json: @salary
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_win_shares
    if @player

      membership = Membership.find_by(season_id: @season.id, team_id: @team.id)
      adv = Adv.find_by(membership_id: membership.id)

        if adv
          win_shares = adv[:ws]
          @win_shares = { name: @player.name, ws: win_shares }
        else
          @win_shares = { name: @player.name, ws: 0 }
        end

      render json: @win_shares
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_win_shares_index
    if @player

      membership = Membership.find_by(season_id: @season.id, team_id: @team.id)
      adv = Adv.find_by(membership_id: membership.id)
      salary = membership[:salary].to_i

        if adv && salary > 0
          win_shares = adv[:ws]

          ws_index = win_shares / salary
          ws_index *= 1000000
          ws_index = (ws_index * 100).round / 100.0

          @ws_index = { name: @player.name, salary: salary, ws: win_shares, ws_index: ws_index }
        else
          @ws_index = { name: @player.name, salary: salary, ws: 0, ws_index: 0 }
        end

      render json: @ws_index
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  def show_cost_per_point
    if @player

      membership = Membership.find_by(season_id: @season.id, team_id: @team.id)
      stat = Stat.find_by(membership_id: membership.id)
      salary = membership[:salary].to_i

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
    team_id = params[:team_id].to_i
    if team_id < 1
      begin
        @team = @season.teams.find_by(br_id: params[:team_id].upcase)
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    else
      begin
        @team = @season.teams.find(params[:team_id])
      rescue ActiveRecord::RecordNotFound => e
        @team = nil
      end
    end
  end

  def set_player
    if !@season
      set_season
    end
    if !@team
      set_team
    end
    player_id = params[:id].to_i
    if player_id < 1
      begin
        @player = @team.players.find_by(name: params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @player = nil
      end
    else
      begin
        @player = @team.players.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @player = nil
      end
    end
  end
end
