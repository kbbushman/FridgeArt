Rails.application.routes.draw do

	root to: 'welcome#show'

	get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/users/:user_id/all-galleries', to: 'user_galleries#index', as: 'user_galleries'
  post '/users/:user_id/all-children/:id', to: 'user_galleries#create'
  get '/users/:user_id/all-children/:id/all-galleries/new', to: 'user_galleries#new', as: 'new_user_gallery'
  get '/users/:user_id/all-galleries/:id/edit', to: 'user_galleries#edit', as: 'edit_user_gallery'
  get '/users/:user_id/all-galleries/:id', to: 'user_galleries#show', as: 'user_gallery'
  patch '/users/:user_id/all-galleries/:id', to: 'user_galleries#update'
  delete '/users/:user_id/all-galleries/:id', to: 'user_galleries#destroy'

  get '/users/:user_id/all-children', to: 'user_children#index', as: 'all_children'
  post '/users/:user_id/all-children', to: 'user_children#create'
  get '/users/:user_id/all-children/new', to: 'user_children#new', as: 'new_all_child'
  get '/users/:user_id/all-children/:id/edit', to: 'user_children#edit', as: 'edit_all_child'
  get '/users/:user_id/all-children/:id', to: 'user_children#show', as: 'all_child'
  patch '/users/:user_id/all-children/:id', to: 'user_children#update'
  delete '/users/:user_id/all-children/:id', to: 'user_children#destroy'

  get '/users/:user_id/all-photos', to: 'user_photos#index', as: 'all_photos'
  post '/users/:user_id/all-galleries/:id', to: 'user_photos#create'
  get '/users/:user_id/all-galleries/:id/all-photos/new', to: 'user_photos#new', as: 'new_all_photo'
  get '/users/:user_id/all-photos/:id/edit', to: 'user_photos#edit', as: 'edit_all_photo'
  get '/users/:user_id/all-photos/:id', to: 'user_photos#show', as: 'all_photo'
  patch '/users/:user_id/all-photos/:id', to: 'user_photos#update'
  delete '/users/:user_id/all-photos/:id', to: 'user_photos#destroy'

	resources :users do
		resources :children do
			resources :galleries do
				resources :photos
			end
		end
	end

end
