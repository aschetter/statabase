class SeasonsController < ApplicationController

  def index
    @seasons = Season.all
    render json: @seasons
  end

  def show
    @season = Season.find(params[:id])

    if @season
      render json: @season
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

end
