Rails.application.routes.draw do
  root to: 'static_pages#home'

  get '/learn' => 'static_pages#learn'
  get '/stats' => 'static_pages#stats'
  get '/logout' => 'static_pages#logout'
  get '/login' => 'static_pages#login'

  namespace :api do
    resources :users, only: [:create]
    patch 'users/:id/color_theme' => 'users#update_color_theme'
    get 'users/:id/color_theme' => 'users#get_color_theme'
    get 'users/:id/stats' => 'stats#show'
    get 'users/:id/stats/win' => 'stats#update_win'
    get 'users/:id/stats/loss' => 'stats#update_loss'
    get 'users/:id/stats/draw' => 'stats#update_draw'
    get 'users/:id/stats/reset' => 'stats#reset_stats'
    resources :sessions, only: [:create, :destroy, :authenticated]
    resources :games, only: [:create] do
      resources :moves, only: [:create, :index] do
        delete :delete_last_move, on: :collection
      end
    end
    get '/sessions/authenticated' => 'sessions#authenticated'
  end
end
