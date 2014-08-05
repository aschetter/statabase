class SalariesController < ApplicationController
  before_action :set_season
  before_action :set_team

  def index
    if @season && !@team && @in_db
      response = Array.new
      players = @season.teams.map do |team| 
        team.players.map do |player| 
          response << { name: player.name, team: team.br_id, salary: player.salary }
        end
      end

      @salaries = response.sort_by { |player| player[:salary].to_f }.reverse
      render json: @salaries

    elsif @season && @team
      salaries = @team.players.all.map do |player|
        {name: player.name, salary: player.salary}
      end
      @salaries = salaries.sort_by { |player| player[:salary].to_f }.reverse
      render json: @salaries
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

    total = @season.teams.length
    if total > params[:team_id].to_i
      @in_db = true
    end

    team_id = params[:team_id].to_i
    if team_id < 1
      begin
        @team = @season.teams.find_by(br_id: params[:team_id])
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
end
