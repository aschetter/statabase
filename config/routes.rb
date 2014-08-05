Rails.application.routes.draw do

  resources :seasons, only: [:index, :show] do
    resources :salaries, only: [:index]
    resources :teams, only: [:index, :show] do
      resources :salaries, only: [:index]
      resources :players, only: [:index, :show] do
        resources :advs, only: [:index, :show]
        resources :stats, only: [:index, :show]
      end
    end
  end
end


#   get 'financials'                  => 'financials#index'
#   get 'financials/win_shares'       => 'financials#win_shares'
#   get 'financials/roi'              => 'financials#roi'
#   get 'financials/cost_per_point'   => 'financials#cost_per_point'
#   get 'financials/cost_per_rebound' => 'financials#cost_per_rebound'
#   get 'financials/cost_per_block'   => 'financials#cost_per_block'
#   get 'financials/cost_per_minute'  => 'financials#cost_per_minute'
#   get 'financials/cost_per_assist'  => 'financials#cost_per_assist'
#   get 'financials/salaries/teams/'  => 'financials#team_salaries'
