Rails.application.routes.draw do

	root to: 'welcome#show'

	resources :users

end
