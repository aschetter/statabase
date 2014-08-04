class TeamsController < ApplicationController
  before_action :set_team, only: [:show]

  def index
    @teams = Season.find(params[:season_id]).teams.all
    render json: @teams
  end

  def show
    if @team
      render json: @team
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

private
 
  def set_team
    @team = Team.find(params[:id])
  end
end
