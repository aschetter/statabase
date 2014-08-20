Rails.application.routes.draw do

  root to: "documentation#index"

  def stats_routes
    get 'stats', :on => :member
    get 'advanced_stats', :on => :member
  end

  def financial_routes
    get 'salaries', :on => :member
    get 'win_shares', :on => :member
    get 'win_shares_index', :on => :member

    get 'cost_per_point', :on => :member
    get 'cost_per_assist', :on => :member
    get 'cost_per_rebound', :on => :member
    get 'cost_per_block', :on => :member
    get 'cost_per_minute', :on => :member
  end

  ###### SEASONS ROUTES ########

  resources :seasons, only: [ :index, :show ] do
    stats_routes
    financial_routes

  ###### TEAMS ROUTES ########

    resources :teams, only: [ :index, :show ] do
      stats_routes
      financial_routes

  ###### PLAYERS ROUTES ########

      resources :players, only: [ :index, :show ] do
        stats_routes
        financial_routes
      end
    end
  end
end
