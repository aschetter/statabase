class AdvsController < ApplicationController
  before_action :set_adv, only: [:show]
  before_action :set_player

  def index
    @adv = @player.adv
    render json: @adv
  end

  def show
    if @adv
      render json: @player
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  private

  def set_adv
    if !@player
      set_player
    end
    @adv = @player.adv.find(params[:id])
  end

  def set_player
    @player = Player.find(params[:player_id])
  end
end
