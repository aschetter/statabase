class StatsController < ApplicationController
  before_action :set_stat, only: [:show]
  before_action :set_player

  def index
    @stat = @player.stat
    render json: @stat
  end

  def show
    if @stat
      render json: @player
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  private

  def set_stat
    if !@player
      set_player
    end
    @stat = @player.stat.find(params[:id])
  end

  def set_player
    @player = Player.find(params[:player_id])
  end
end
