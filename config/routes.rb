Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :comps, :controller => :lc_comps do
				resources :classes, :controller => :lc_classes, shallow: true
			end
		end
	end
end
