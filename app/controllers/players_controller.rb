class PlayersController < ApplicationController

  def index
    render json: Player.all
  end

  def show
    @player = Player.find(params[:id])

    if @player
      render json: @player
    else
      render status: 404, json: { status: :could_not_find }
    end
  end
end

# variable = "Fox"
# Project.where("project_name like ?", "%#{variable}%")
