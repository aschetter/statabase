class TeamsController < ApplicationController

  def index
    @teams = Team.all
    render json: @teams
  end

  def show
    @team = Season.find(params[:id])

    if @team
      render json: @team
    else
      render status: 404, json: { status: :could_not_find }
    end
  end
end
