Rails.application.routes.draw do

  ###### SEASONS ROUTES ########

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

  ###### TEAMS ROUTES ########

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

  ###### PLAYERS ROUTES ########

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
end
