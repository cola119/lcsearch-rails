class Api::V1::LcCompsController < ApplicationController
	def search
		return response_bad_request if params[:name].blank?
		@comps = LcComp.where("name LIKE ?", '%'+params[:name]+'%').order(created_at: :desc)
		return response_not_found(:comps) if @comps.blank?
		response_success(:comps, :search, @comps)
	end

	def index
		@comps = LcComp.order(created_at: :desc)
		return response_not_found(:comps) if @comps.nil?
		response_success(:comps, :index, @comps)
	end

	def show
		@comp = LcComp.find_by_id(params[:id])
		return response_not_found(:comp) if @comp.nil?
		response_success(:comp, :show, @comp)
	end

	def create
		@comp = LcComp.new(comp_params)
		return response_bad_request unless @comp.valid?
		@comp.save ? response_success(:comp, :create, @comp) : response_internal_server_error
	end

	def destroy
		@comp = LcComp.find_by_id(params[:id])
		return response_not_found(:comp) if @comp.nil?
		@comp.destroy
		response_success(:comp, :destroy, @comp)
	end

	def update
		@comp = LcComp.find_by_id(params[:id])
		return response_not_found(:comp) if @comp.nil?
		@comp.update(comp_params) ? response_success(:comp, :update, LcComp.find_by_id(params[:id])) : response_internal_server_error
		# @comp.update(comp_params) ? response_success(:comp, :update, @comp) : response_internal_server_error
	end

	private
		def comp_params
		  params.permit(:name, :date, :terrain, :owner, :link, :lc_link)
		end
end
