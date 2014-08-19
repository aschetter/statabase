Rails.application.routes.draw do

  get '/seasons', to: 'seasons#index'
  get '/seasons/:id', to: 'seasons#show'

  get '/seasons/:id/salaries', to: 'seasons#show_salaries'
  get '/seasons/:id/win_shares', to: 'seasons#show_win_shares'
  get '/seasons/:id/win_shares_index', to: 'seasons#show_win_shares_index'

  get '/seasons/:id/cost_per_point', to: 'seasons#show_cost_per_point'
  get '/seasons/:id/cost_per_assist', to: 'seasons#show_cost_per_assist'
  get '/seasons/:id/cost_per_rebound', to: 'seasons#show_cost_per_rebound'
  get '/seasons/:id/cost_per_block', to: 'seasons#show_cost_per_block'
  get '/seasons/:id/cost_per_minute', to: 'seasons#show_cost_per_minute'


  # resources :seasons, only: [:index, :show] do

  #   # resources :salaries, only: [:index]-------
  #   # resources :win_shares, only: [:index]-------
  #   # resources :rois, only: [:index]-------
  #   # resources :cost_per_points, only: [:index]-------
  #   # resources :cost_per_assists, only: [:index]-------
  #   # resources :cost_per_rebounds, only: [:index]-------
  #   # resources :cost_per_blocks, only: [:index]-------
  #   # resources :cost_per_mins, only: [:index]-------

  #   resources :teams, only: [:index, :show] do

  #     # resources :salaries, only: [:index]
  #     # resources :win_shares, only: [:index]
  #     # resources :rois, only: [:index]
  #     # resources :cost_per_points, only: [:index]
  #     # resources :cost_per_assists, only: [:index]
  #     # resources :cost_per_rebounds, only: [:index]
  #     # resources :cost_per_blocks, only: [:index]
  #     # resources :cost_per_mins, only: [:index]
  #     resources :players, only: [:index, :show] do
        
  #       # resources :advs, only: [:index]
  #       # resources :stats, only: [:index]
  #       # resources :salaries, only: [:index]
  #       # resources :win_shares, only: [:index]
  #       # resources :rois, only: [:index]
  #       # resources :cost_per_points, only: [:index]
  #       # resources :cost_per_assists, only: [:index]
  #       # resources :cost_per_rebounds, only: [:index]
  #       # resources :cost_per_blocks, only: [:index]
  #       # resources :cost_per_mins, only: [:index]
  #     end
  #   end
  # end
end
