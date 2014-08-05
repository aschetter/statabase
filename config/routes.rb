Rails.application.routes.draw do

  resources :seasons, only: [:index, :show] do
    resources :salaries, only: [:index]
    resources :win_shares, only: [:index]
    resources :rois, only: [:index]
    resources :teams, only: [:index, :show] do

      resources :salaries, only: [:index]
      resources :win_shares, only: [:index]
      resources :rois, only: [:index]
      resources :players, only: [:index, :show] do
        
        resources :advs, only: [:index]
        resources :stats, only: [:index]
      end
    end
  end
end


#   get 'financials'                  => 'financials#index'
#   get 'financials/roi'              => 'financials#roi'
#   get 'financials/cost_per_point'   => 'financials#cost_per_point'
#   get 'financials/cost_per_rebound' => 'financials#cost_per_rebound'
#   get 'financials/cost_per_block'   => 'financials#cost_per_block'
#   get 'financials/cost_per_minute'  => 'financials#cost_per_minute'
#   get 'financials/cost_per_assist'  => 'financials#cost_per_assist'
#   get 'financials/salaries/teams/'  => 'financials#team_salaries'
