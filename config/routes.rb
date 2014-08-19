Rails.application.routes.draw do

  ###### SEASONS ROUTES ########

  get '/seasons', to: 'seasons#index'
  get '/seasons/:id', to: 'seasons#show'

  get '/seasons/:id/stats', to: 'seasons#show_stats'
  get '/seasons/:id/advanceds', to: 'seasons#show_advanceds'

  get '/seasons/:id/salaries', to: 'seasons#show_salaries'
  get '/seasons/:id/win_shares', to: 'seasons#show_win_shares'
  get '/seasons/:id/win_shares_index', to: 'seasons#show_win_shares_index'

  get '/seasons/:id/cost_per_point', to: 'seasons#show_cost_per_point'
  get '/seasons/:id/cost_per_assist', to: 'seasons#show_cost_per_assist'
  get '/seasons/:id/cost_per_rebound', to: 'seasons#show_cost_per_rebound'
  get '/seasons/:id/cost_per_block', to: 'seasons#show_cost_per_block'
  get '/seasons/:id/cost_per_minute', to: 'seasons#show_cost_per_minute'

  ###### TEAMS ROUTES ########

  get '/seasons/:season_id/teams', to: 'teams#index'
  get '/seasons/:season_id/teams/:id', to: 'teams#show'
  get '/seasons/:season_id/teams/:id/salaries', to: 'teams#show_salaries'
  get '/seasons/:season_id/teams/:id/win_shares', to: 'teams#show_win_shares'
  get '/seasons/:season_id/teams/:id/win_shares_index', to: 'teams#show_win_shares_index'

  get '/seasons/:season_id/teams/:id/cost_per_point', to: 'teams#show_cost_per_point'
  get '/seasons/:season_id/teams/:id/cost_per_assist', to: 'teams#show_cost_per_assist'
  get '/seasons/:season_id/teams/:id/cost_per_rebound', to: 'teams#show_cost_per_rebound'
  get '/seasons/:season_id/teams/:id/cost_per_block', to: 'teams#show_cost_per_block'
  get '/seasons/:season_id/teams/:id/cost_per_minute', to: 'teams#show_cost_per_minute'

  ###### PLAYERS ROUTES ########

  get '/seasons/:season_id/teams/:team_id/players', to: 'players#index'
  get '/seasons/:season_id/teams/:team_id/players/:id', to: 'players#show'
  get '/seasons/:season_id/teams/:team_id/players/:id/salaries', to: 'players#show_salaries'
  get '/seasons/:season_id/teams/:team_id/players/:id/win_shares', to: 'players#show_win_shares'
  get '/seasons/:season_id/teams/:team_id/players/:id/win_shares_index', to: 'players#show_win_shares_index'

  get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_point', to: 'players#show_cost_per_point'
  get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_assist', to: 'players#show_cost_per_assist'
  get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_rebound', to: 'players#show_cost_per_rebound'
  get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_block', to: 'players#show_cost_per_block'
  get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_minute', to: 'players#show_cost_per_minute'

end
