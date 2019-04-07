class Api::V1::LcResultsController < ApplicationController
	before_action :require_have_comp_class, except: [:search]

	def search
		query_name = params[:name].blank? ? nil : params[:name].strip.empty? ? nil : '%'+params[:name].strip+'%'
		query_club = params[:club].blank? ? nil : params[:club].strip.empty? ? nil : '%'+params[:club].strip+'%'
		if query_name.nil? || query_club.nil?
			@results =  LcResult.where("(name LIKE ?) OR (club LIKE ?)", query_name, query_club).order(created_at: :desc)
		else
			@results =  LcResult.where("(name LIKE ?) AND (club LIKE ?)", query_name, query_club).order(created_at: :desc)
		end
		render json: @results
	end

	# GET    /api/v1/comps/:comp_id/classes/:class_id/results
	def index
		@results = @class.lc_result.all
		render json: @results
	end

	# POST   /api/v1/comps/:comp_id/classes/:class_id/results
	def create
		@result = @class.lc_result.build(result_params)
		render json: @result.save ? @result : @result.errors
	end

	# GET    /api/v1/comps/:comp_id/classes/:class_id/results/:id
	def show
		@result = @class.lc_results.find_by_id(params[:id])
		render json: @result
	end

	# PATCH  /api/v1/comps/:comp_id/classes/:class_id/results/:id
	def update
		@result = LcResult.find_by_id(params[:id])
		render json: @result.nil? ? nil : @result.update(result_params) ? @result : @result.errors
	end

	# DELETE /api/v1/comps/:comp_id/classes/:class_id/results/:id
	def destroy
		@result = LcResult.find_by_id(params[:id])
		@result.destroy unless @result.nil?
		render json: @result
	end

	private
		def result_params
		  params.permit(:name, :runner_id, :ecard, :club, :start, :result, :rank, :speed, :loss_rate, :total_relative, :total_losstime, :ideal_time)
		end

		def require_have_comp_class
			@comp = LcComp.find_by_id(params[:comp_id])
			if @comp.nil?
				render json: {"status": "error"}
				return
			end
			@class = @comp.lc_classes.find_by_id(params[:class_id])
			if @class.nil?
				render json: {"status": "error"}
				return
			end
		end
end
