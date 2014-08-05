class SeasonsController < ApplicationController
  before_action :set_season

  def index
    @seasons = Season.all
    render json: @seasons
  end

  def show
    if @season
      render json: @season
    else
      render status: 404, json: { status: :could_not_find }
    end
  end

  private

  def set_season
    begin
      @season = Season.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @season = nil
    end
  end
end
