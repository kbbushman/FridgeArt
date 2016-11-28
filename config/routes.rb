Rails.application.routes.draw do

  # Set home page
	root to: 'welcome#show'

  # Session resources for user auth
	get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  # User resources
	get '/users', to: 'users#index', as: 'users'
  post '/users', to: 'users#create'
  get '/users/new', to: 'users#new', as: 'new_user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  get '/users/:id', to: 'users#show', as: 'user'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'

  # Child resources for Add Photo nav button
  get '/users/:user_id/children', to: 'children#index', as: 'user_children'
  post '/users/:user_id/children', to: 'children#create'
  get '/users/:user_id/children/new', to: 'children#new', as: 'new_user_child'
  get '/users/:user_id/children/:id', to: 'children#show', as: 'user_child'

  # Gallery resources for Add Photo nav button
  get '/users/:user_id/children/:child_id/galleries', to: 'galleries#index', as: 'user_child_galleries'
  post '/users/:user_id/children/:child_id/galleries', to: 'galleries#create'
  get '/users/:user_id/children/:child_id/galleries/new', to: 'galleries#new', as: 'new_user_child_gallery'
  get '/users/:user_id/children/:child_id/galleries/:id', to: 'galleries#show', as: 'user_child_gallery'

  # Photo resources for Add Photo nav button
  get '/users/:user_id/children/:child_id/galleries/:gallery_id/photos', to: 'photos#index', as: 'user_child_gallery_photos'
  post '/users/:user_id/children/:child_id/galleries/:gallery_id/photos', to: 'photos#create'
  get '/users/:user_id/children/:child_id/galleries/:gallery_id/photos/new', to: 'photos#new', as: 'new_user_child_gallery_photo'
  get '/users/:user_id/children/:child_id/galleries/:gallery_id/photos/:id', to: 'photos#show', as: 'user_child_gallery_photo'

  # Gallery resources for All Galleries nav button
  get '/users/:user_id/all-galleries', to: 'user_galleries#index', as: 'user_galleries'
  post '/users/:user_id/all-children/:id', to: 'user_galleries#create'
  get '/users/:user_id/all-children/:id/all-galleries/new', to: 'user_galleries#new', as: 'new_user_gallery'
  get '/users/:user_id/all-galleries/:id/edit', to: 'user_galleries#edit', as: 'edit_user_gallery'
  get '/users/:user_id/all-galleries/:id', to: 'user_galleries#show', as: 'user_gallery'
  patch '/users/:user_id/all-galleries/:id', to: 'user_galleries#update'
  delete '/users/:user_id/all-galleries/:id', to: 'user_galleries#destroy'

  # Child resources for All Children nav button
  get '/users/:user_id/all-children', to: 'user_children#index', as: 'all_children'
  post '/users/:user_id/all-children', to: 'user_children#create'
  get '/users/:user_id/all-children/new', to: 'user_children#new', as: 'new_all_child'
  get '/users/:user_id/all-children/:id/edit', to: 'user_children#edit', as: 'edit_all_child'
  get '/users/:user_id/all-children/:id', to: 'user_children#show', as: 'all_child'
  patch '/users/:user_id/all-children/:id', to: 'user_children#update'
  delete '/users/:user_id/all-children/:id', to: 'user_children#destroy'

  # Photo resources for All Photos nav button
  get '/users/:user_id/all-photos', to: 'user_photos#index', as: 'all_photos'
  post '/users/:user_id/all-galleries/:id', to: 'user_photos#create'
  get '/users/:user_id/all-galleries/:id/all-photos/new', to: 'user_photos#new', as: 'new_all_photo'
  get '/users/:user_id/all-photos/:id/edit', to: 'user_photos#edit', as: 'edit_all_photo'
  get '/users/:user_id/all-photos/:id', to: 'user_photos#show', as: 'all_photo'
  patch '/users/:user_id/all-photos/:id', to: 'user_photos#update'
  delete '/users/:user_id/all-photos/:id', to: 'user_photos#destroy'

  # Error 404 resource for unmatched routes
  get '*unmatched_route', to: 'application#raise_not_found'

end
