Fgr::Application.routes.draw do

	get 'sign_out' => 'sessions#destroy', as: 'sign_out'
	get 'sign_in' => 'sessions#new', as: 'sign_in'
	get 'sign_up' => 'users#new', as: 'sign_up'

	resources :pages, only: [] do
		get 'about', on: :collection
	end

	resources :requests, only: [:show]
	resources :users
	resources :sessions
	resources :password_resets

	resources :games do
		get 'votable', on: :collection
	end

	root to: 'games#index'
end
