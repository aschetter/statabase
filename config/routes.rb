Rails.application.routes.draw do

  ###### SEASONS ROUTES ########

  # get '/seasons', to: 'seasons#index'
  # get '/seasons/:id', to: 'seasons#show'

  # get '/seasons/:id/stats', to: 'seasons#show_stats'
  # get '/seasons/:id/advanced_stats', to: 'seasons#advanced_stats'

  # get '/seasons/:id/salaries', to: 'seasons#salaries'
  # get '/seasons/:id/win_shares', to: 'seasons#win_shares'
  # get '/seasons/:id/win_shares_index', to: 'seasons#win_shares_index'

  # get '/seasons/:id/cost_per_point', to: 'seasons#cost_per_point'
  # get '/seasons/:id/cost_per_assist', to: 'seasons#cost_per_assist'
  # get '/seasons/:id/cost_per_rebound', to: 'seasons#cost_per_rebound'
  # get '/seasons/:id/cost_per_block', to: 'seasons#cost_per_block'
  # get '/seasons/:id/cost_per_minute', to: 'seasons#cost_per_minute'

  ###### TEAMS ROUTES ########


  # get '/seasons/:season_id/teams', to: 'teams#index'
  # get '/seasons/:season_id/teams/:id', to: 'teams#show'

  # get '/seasons/:season_id/teams/:id/stats', to: 'teams#stats'
  # get '/seasons/:season_id/teams/:id/advanced_stats', to: 'teams#advanceds'

  # get '/seasons/:season_id/teams/:id/salaries', to: 'teams#salaries'
  # get '/seasons/:season_id/teams/:id/win_shares', to: 'teams#win_shares'
  # get '/seasons/:season_id/teams/:id/win_shares_index', to: 'teams#win_shares_index'

  # get '/seasons/:season_id/teams/:id/cost_per_point', to: 'teams#cost_per_point'
  # get '/seasons/:season_id/teams/:id/cost_per_assist', to: 'teams#cost_per_assist'
  # get '/seasons/:season_id/teams/:id/cost_per_rebound', to: 'teams#cost_per_rebound'
  # get '/seasons/:season_id/teams/:id/cost_per_block', to: 'teams#cost_per_block'
  # get '/seasons/:season_id/teams/:id/cost_per_minute', to: 'teams#cost_per_minute'

  ###### PLAYERS ROUTES ########

  resources :seasons, only: [ :index, :show ] do
    get 'stats', :on => :member
    get 'advanced_stats', :on => :member

    get 'salaries', :on => :member
    get 'win_shares', :on => :member
    get 'win_shares_index', :on => :member

    get 'cost_per_point', :on => :member
    get 'cost_per_assist', :on => :member
    get 'cost_per_rebound', :on => :member
    get 'cost_per_block', :on => :member
    get 'cost_per_minute', :on => :member

    resources :teams, only: [ :index, :show ] do
      get 'stats', :on => :member
      get 'advanced_stats', :on => :member

      get 'salaries', :on => :member
      get 'win_shares', :on => :member
      get 'win_shares_index', :on => :member

      get 'cost_per_point', :on => :member
      get 'cost_per_assist', :on => :member
      get 'cost_per_rebound', :on => :member
      get 'cost_per_block', :on => :member
      get 'cost_per_minute', :on => :member

      resources :players, only: [ :index, :show ] do
        get 'stats', :on => :member
        get 'advanced_stats', :on => :member

        get 'salaries', :on => :member
        get 'win_shares', :on => :member
        get 'win_shares_index', :on => :member

        get 'cost_per_point', :on => :member
        get 'cost_per_assist', :on => :member
        get 'cost_per_rebound', :on => :member
        get 'cost_per_block', :on => :member
        get 'cost_per_minute', :on => :member
      end
    end
  end

  # get '/seasons/:season_id/teams/:team_id/players', to: 'players#index'
  # get '/seasons/:season_id/teams/:team_id/players/:id', to: 'players#show'

  # get '/seasons/:season_id/teams/:team_id/players/:id/stats', to: 'players#stats'
  # get '/seasons/:season_id/teams/:team_id/players/:id/advanced_stats', to: 'players#advanceds'

  # get '/seasons/:season_id/teams/:team_id/players/:id/salaries', to: 'players#salaries'
  # get '/seasons/:season_id/teams/:team_id/players/:id/win_shares', to: 'players#win_shares'
  # get '/seasons/:season_id/teams/:team_id/players/:id/win_shares_index', to: 'players#win_shares_index'

  # get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_point', to: 'players#cost_per_point'
  # get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_assist', to: 'players#cost_per_assist'
  # get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_rebound', to: 'players#cost_per_rebound'
  # get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_block', to: 'players#cost_per_block'
  # get '/seasons/:season_id/teams/:team_id/players/:id/cost_per_minute', to: 'players#cost_per_minute'

end
