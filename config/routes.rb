Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :comps, :controller => :lc_comps
		end
	end
end
