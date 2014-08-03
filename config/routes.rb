Rails.application.routes.draw do

#   resources :seasons do
#     resources :teams do
#       resources :players do
#       end
#     end
#   end

# resources :seasons do 
#   resources :financials do
#     get '/salaries' => 'financials#salaries'
#   end
# end

# resources :seasons, only: [:index, :show] do
#   resources :teams, only: [:index, :show] do
#     resources :players, only: [:index, :show]
#   end
# end

# resources :seasons, only: [:index, :show] do
#   resources :players, only: [:index, :show]
# end

# resources :players, only: [:index, :show]

get 'financials/salaries' => 'financials#salaries'
get 'financials/rois' => 'financials#win_shares'







#       season_team_players GET    /seasons/:season_id/teams/:team_id/players(.:format)            players#index
#                           POST   /seasons/:season_id/teams/:team_id/players(.:format)            players#create
#    new_season_team_player GET    /seasons/:season_id/teams/:team_id/players/new(.:format)        players#new
#   edit_season_team_player GET    /seasons/:season_id/teams/:team_id/players/:id/edit(.:format)   players#edit
#        season_team_player GET    /seasons/:season_id/teams/:team_id/players/:id(.:format)        players#show
#                           PATCH  /seasons/:season_id/teams/:team_id/players/:id(.:format)        players#update
#                           PUT    /seasons/:season_id/teams/:team_id/players/:id(.:format)        players#update
#                           DELETE /seasons/:season_id/teams/:team_id/players/:id(.:format)        players#destroy
#              season_teams GET    /seasons/:season_id/teams(.:format)                             teams#index
#                           POST   /seasons/:season_id/teams(.:format)                             teams#create
#           new_season_team GET    /seasons/:season_id/teams/new(.:format)                         teams#new
#          edit_season_team GET    /seasons/:season_id/teams/:id/edit(.:format)                    teams#edit
#               season_team GET    /seasons/:season_id/teams/:id(.:format)                         teams#show
#                           PATCH  /seasons/:season_id/teams/:id(.:format)                         teams#update
#                           PUT    /seasons/:season_id/teams/:id(.:format)                         teams#update
#                           DELETE /seasons/:season_id/teams/:id(.:format)                         teams#destroy
#                   seasons GET    /seasons(.:format)                                              seasons#index
#                           POST   /seasons(.:format)                                              seasons#create
#                new_season GET    /seasons/new(.:format)                                          seasons#new
#               edit_season GET    /seasons/:id/edit(.:format)                                     seasons#edit
#                    season GET    /seasons/:id(.:format)                                          seasons#show
#                           PATCH  /seasons/:id(.:format)                                          seasons#update
#                           PUT    /seasons/:id(.:format)                                          seasons#update
#                           DELETE /seasons/:id(.:format)                                          seasons#destroy
# season_financial_salaries GET    /seasons/:season_id/financials/:financial_id/salaries(.:format) financials#salaries
#         season_financials GET    /seasons/:season_id/financials(.:format)                        financials#index
#                           POST   /seasons/:season_id/financials(.:format)                        financials#create
#      new_season_financial GET    /seasons/:season_id/financials/new(.:format)                    financials#new
#     edit_season_financial GET    /seasons/:season_id/financials/:id/edit(.:format)               financials#edit
#          season_financial GET    /seasons/:season_id/financials/:id(.:format)                    financials#show
#                           PATCH  /seasons/:season_id/financials/:id(.:format)                    financials#update
#                           PUT    /seasons/:season_id/financials/:id(.:format)                    financials#update
#                           DELETE /seasons/:season_id/financials/:id(.:format)                    financials#destroy
#                           GET    /seasons(.:format)                                              seasons#index
#                           POST   /seasons(.:format)                                              seasons#create
#                           GET    /seasons/new(.:format)                                          seasons#new
#                           GET    /seasons/:id/edit(.:format)                                     seasons#edit
#                           GET    /seasons/:id(.:format)                                          seasons#show
#                           PATCH  /seasons/:id(.:format)                                          seasons#update
#                           PUT    /seasons/:id(.:format)                                          seasons#update
#                           DELETE /seasons/:id(.:format)                                          seasons#destroy


















  # resources :teams
  # resources :players



  # get 'players/find/:name' => 'players#find_by_name'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
