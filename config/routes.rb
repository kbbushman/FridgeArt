Rails.application.routes.draw do

	root to: 'welcome#show'

	get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

	resources :users
	resources :children do
		resources :galleries do
			resources :photos
		end
	end

end
