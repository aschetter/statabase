Rails.application.routes.draw do

  get '/seasons', to: 'seasons#index'
  get '/seasons/:id', to: 'seasons#show'
  get '/seasons/:id/salaries', to: 'seasons#show_salaries'
  get '/seasons/:id/win_shares', to: 'seasons#show_win_shares'
  get '/seasons/:id/cost_per_win_share', to: 'seasons#show_cost_per_win_share'


  # resources :seasons, only: [:index, :show] do

  #   # resources :salaries, only: [:index]-------
  #   # resources :win_shares, only: [:index]-------
  #   # resources :rois, only: [:index]-------
  #   # resources :cost_per_points, only: [:index]
  #   # resources :cost_per_assists, only: [:index]
  #   # resources :cost_per_rebounds, only: [:index]
  #   # resources :cost_per_blocks, only: [:index]
  #   # resources :cost_per_mins, only: [:index]
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
