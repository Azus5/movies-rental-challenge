Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, only: %i[index] do
    get :recommendations, on: :collection
    get :rent, on: :member
  end

  # backwards compatibility
  get '/movies/user_rented_movies', to: redirect { |_params, request| "/users/rented_movies?#{request.query_string}" }

  scope :users do
    get '/rented_movies', to: 'users#rented_movies'
  end
end
