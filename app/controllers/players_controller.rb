class PlayersController < ApplicationController

  def season_index
    @players = Season.find(params[:id]).teams.map do |team|
      team.players
    end
    render json: @players
  end

  def index
    @players = Team.find(params[:team_id]).players.all
    render json: @players
  end

  def show
    @player = Team.find(params[:team_id]).players.find(params[:id])
    render json: @player
  end
end
