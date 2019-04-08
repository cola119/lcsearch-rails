class Api::V1::LcResultsController < ApplicationController
	before_action :require_have_comp_class, except: [:search]

	def search
		query_name = params[:name].blank? ? nil : '%'+params[:name].strip+'%'
		query_club = params[:club].blank? ? nil : '%'+params[:club].strip+'%'
		if query_name.nil? && query_club.nil?
			return response_bad_request
		elsif query_name.nil? || query_club.nil?
			@results =  LcResult.where("(name LIKE ?) OR (club LIKE ?)", query_name, query_club).order(created_at: :desc)
		else
			@results =  LcResult.where("(name LIKE ?) AND (club LIKE ?)", query_name, query_club).order(created_at: :desc)
		end
		return response_not_found(:results) if @results.blank?
		response_success(:results, :search, @results)
	end

	# GET    /api/v1/comps/:comp_id/classes/:class_id/results
	def index
		@results = @class.lc_result.order(created_at: :desc)
		return response_not_found(:results) if @results.blank?
		response_success(:results, :index, @results)
	end

	# POST   /api/v1/comps/:comp_id/classes/:class_id/results
	def create
		@result = @class.lc_result.build(result_params)
		return response_bad_request unless @result.valid?
		@result.save ? response_success(:result, :create, @result) : response_internal_server_error
	end

	# GET    /api/v1/comps/:comp_id/classes/:class_id/results/:id
	def show
		@result = @class.lc_results.find_by_id(params[:id])
		return response_not_found(:result) if @result.nil?
		response_success(:result, :show, @result)
	end

	# PATCH  /api/v1/comps/:comp_id/classes/:class_id/results/:id
	def update
		@result = LcResult.find_by_id(params[:id])
		return response_not_found(:result) if @result.nil?
		@result.update(result_params) ? response_success(:result, :update, LcResult.find_by_id(params[:id])) : response_internal_server_error
	end

	# DELETE /api/v1/comps/:comp_id/classes/:class_id/results/:id
	def destroy
		@result = LcResult.find_by_id(params[:id])
		return response_not_found(:result) if @result.nil?
		@result.destroy
		response_success(:result, :destroy, @result)
	end

	private
		def result_params
		  params.permit(:name, :runner_id, :ecard, :club, :start, :result, :rank, :speed, :loss_rate, :total_relative, :total_losstime, :ideal_time)
		end

		def require_have_comp_class
			@comp = LcComp.find_by_id(params[:comp_id])
			return response_bad_request if @comp.nil?
			@class = @comp.lc_classes.find_by_id(params[:class_id])
			return response_bad_request if @class.nil?
		end
end
