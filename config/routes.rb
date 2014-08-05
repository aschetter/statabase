Rails.application.routes.draw do

  resources :seasons, only: [:index, :show] do
    resources :salaries, only: [:index]
    resources :win_shares, only: [:index]
    resources :rois, only: [:index]
    resources :cost_per_points, only: [:index]
    resources :cost_per_assists, only: [:index]
    resources :cost_per_rebounds, only: [:index]
    resources :cost_per_blocks, only: [:index]
    resources :teams, only: [:index, :show] do

      resources :salaries, only: [:index]
      resources :win_shares, only: [:index]
      resources :rois, only: [:index]
      resources :cost_per_points, only: [:index]
      resources :cost_per_assists, only: [:index]
      resources :cost_per_rebounds, only: [:index]
      resources :cost_per_blocks, only: [:index]
      resources :players, only: [:index, :show] do
        
        resources :advs, only: [:index]
        resources :stats, only: [:index]
      end
    end
  end
end

#   get 'financials/cost_per_minute'  => 'financials#cost_per_minute'
#   get 'financials/cost_per_assist'  => 'financials#cost_per_assist'
