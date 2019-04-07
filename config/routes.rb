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
				resources :classes, :controller => :lc_classes do
					resources :results, :controller => :lc_results
				end
			end
		end
	end
end
