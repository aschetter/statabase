Rails.application.routes.draw do

  resources :seasons, only: [:index, :show] do
    resources :salaries, only: [:index]
    resources :win_shares, only: [:index]
    resources :rois, only: [:index]
    resources :cost_per_points, only: [:index]
    resources :cost_per_assists, only: [:index]
    resources :cost_per_rebounds, only: [:index]
    resources :cost_per_blocks, only: [:index]
    resources :cost_per_mins, only: [:index]
    resources :teams, only: [:index, :show] do

      resources :salaries, only: [:index]
      resources :win_shares, only: [:index]
      resources :rois, only: [:index]
      resources :cost_per_points, only: [:index]
      resources :cost_per_assists, only: [:index]
      resources :cost_per_rebounds, only: [:index]
      resources :cost_per_blocks, only: [:index]
      resources :cost_per_mins, only: [:index]
      resources :players, only: [:index, :show] do
        
        resources :advs, only: [:index]
        resources :stats, only: [:index]
        resources :salaries, only: [:index]
        resources :win_shares, only: [:index]
        resources :rois, only: [:index]
        resources :cost_per_points, only: [:index]
        resources :cost_per_assists, only: [:index]
        resources :cost_per_rebounds, only: [:index]
        resources :cost_per_blocks, only: [:index]
        resources :cost_per_mins, only: [:index]
      end
    end
  end
end
