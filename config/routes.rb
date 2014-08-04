Rails.application.routes.draw do

# resources :seasons do 
#   resources :financials do
#     get '/salaries' => 'financials#salaries'
#   end
# end

  resources :seasons, only: [:index, :show] do
    resources :teams, only: [:index, :show] do
      resources :players, only: [:index, :show] do
      resources :advs, only: [:index, :show]
      resources :stats, only: [:index, :show]
      end
    end
  end

  get 'seasons/:id/players' => 'players#season_index'
  get 'financials' => 'financials#index'
  get 'financials/salaries' => 'financials#salaries'
  get 'financials/win_shares' => 'financials#win_shares'
  get 'financials/roi' => 'financials#roi'

end
