Rails.application.routes.draw do
	namespace :v1, module: 'api/v1' do
		resources :answers, only: [:show, :create, :update, :destroy] do
			resources :comments, only: [:index, :create, :update, :destroy] do
				resources :revisions, only: :index
			end
			resources :edits, only: :index do
				resources :votes, only: [:index, :create, :destroy]
			end
			resources :stats, only: :show
			resources :revisions, only: :index
			resources :votes, only: [:index, :create, :destroy]
		end
		resources :badges, only: [:index, :show, :create, :update, :destroy] do
			resources :users, only: :index
		end
		resource :login, controller: 'sessions', only: :create
		resources :logout, controller: 'sessions', only: :destroy
		resources :posts do
			resources :answers, only: [:index]
			resources :comments, only: [:index, :create, :update, :destroy] do
				resources :revisions, only: :index
			end
			resources :edits, only: :index do
				resources :votes, only: [:index, :create, :destroy]
			end
			resources :stats, only: :show
			resources :recommendations, only: :index
			resources :revisions, only: :index
			resources :votes, only: [:index, :create, :destroy]
		end
		resources :tags, only: [:index, :show, :create, :update, :destroy] do
			resources :posts, only: :index
		end
		resources :users do
			resources :answers, only: [:index]
			resources :comments, only: :index
			resources :edits, only: :index
			resources :posts, only: :index
			resources :user_stats, only: :show
			resources :votes, only: :index
		end
		resources :vote_types do
			resources :votes, only: :index
		end
	end
end
