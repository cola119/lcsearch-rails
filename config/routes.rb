Rails.application.routes.draw do
	# namespace :api do
	# 	namespace :v1 do
	# 		resources :comps, :controller => :lc_comps do
	# 			resources :classes, :controller => :lc_classes, only: [:index, :create] do
	# 				resources :results, :controller => :lc_results, shallow: true
	# 			end
	# 		end
	# 		resources :classes, :controller => :lc_classes, only: [:show, :update, :destroy]
	# 	end
	# end
	namespace :api do
		namespace :v1 do
			resources :comps, :controller => :lc_comps do
				collection do
					get 'search'
				end
				resources :classes, :controller => :lc_classes do
					resources :results, :controller => :lc_results
				end
			end
			get '/results/search', to: 'lc_results#search'
		end
	end
	get '*path', controller: 'application', action: 'response_not_found'
end
