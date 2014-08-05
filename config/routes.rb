Rails.application.routes.draw do

  resources :seasons, only: [:index, :show] do
    resources :teams, only: [:index, :show] do
      resources :players, only: [:index, :show] do
        resources :advs, only: [:index, :show]
        resources :stats, only: [:index, :show]
      end
    end
  end



 # /seasons/salaries

 # seasons/1/salaries

 # seasons/1/teams/1/salaries

 # seasons/1/teams/1/players/1/salaries

  get 'financials'                  => 'financials#index'
  get 'financials/salaries'         => 'financials#salaries'
  get 'financials/win_shares'       => 'financials#win_shares'
  get 'financials/roi'              => 'financials#roi'
  get 'financials/cost_per_point'   => 'financials#cost_per_point'
  get 'financials/cost_per_rebound' => 'financials#cost_per_rebound'
  get 'financials/cost_per_block'   => 'financials#cost_per_block'
  get 'financials/cost_per_minute'  => 'financials#cost_per_minute'
  get 'financials/cost_per_assist'  => 'financials#cost_per_assist'
  get 'financials/salaries/teams/'  => 'financials#team_salaries'


Season.find(params[:season_id]).teams.map do |team| 
  team.players.map do |player| 
    player
  end
end
