class PlayersController < ApplicationController

  def index
    if !params[:team_id]
      @players = Season.find(params[:season_id]).teams.map do |team|
        team.players
      end
    else
      @players = Team.find(params[:team_id]).players.all
    end

    render json: @players
  end

  def show
    @player = Team.find(params[:team_id]).players.find(params[:id])
    render json: @player
  end
end
