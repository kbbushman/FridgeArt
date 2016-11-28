Rails.application.routes.draw do

	root to: 'welcome#show'

	get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/users/:user_id/all-galleries', to: 'user_galleries#index', as: 'user_galleries'
  get '/users/:user_id/all-galleries/:id/edit', to: 'user_galleries#edit', as: 'edit_user_gallery'
  get '/users/:user_id/all-galleries/:id', to: 'user_galleries#show', as: 'user_gallery'
  patch '/users/:user_id/all-galleries/:id', to: 'user_galleries#update'
  delete '/users/:user_id/all-galleries/:id', to: 'user_galleries#destroy'

  # get '/users/:user_id/children', to: 'user_children#index', as: 'user_children'
  # get '/users/:user_id/children/:id', to: 'user_children#show', as: 'user_child'

	resources :users do
		resources :children do
			resources :galleries do
				resources :photos
			end
		end
	end

end
