class Api::V1::LcClassesController < ApplicationController
	before_action :require_have_comp

	def index
		@classes = @comp.lc_classes.order(created_at: :desc)
		return response_not_found(:classes) if @classes.blank?
		response_success(:classes, :index, @classes)
	end

	def show
		@class = @comp.lc_classes.find_by_id(params[:id])
		return response_not_found(:class) if @class.nil?
		response_success(:class, :show, @class)
	end

	def create
		@class = @comp.lc_classes.build(class_params)
		return response_bad_request unless @class.valid?
		@class.save ? response_success(:class, :create, @class) : response_internal_server_error
	end

	def destroy
		@class = LcClass.find_by_id(params[:id])
		return response_not_found(:class) if @class.nil?
		@class.destroy
		response_success(:class, :destroy, @class)
	end

	def update
		@class = LcClass.find_by_id(params[:id])
		return response_not_found(:class) if @class.nil?
		@class.update(class_params) ? response_success(:class, :update, LcClass.find_by_id(params[:id])) : response_internal_server_error
	end

	private
		def class_params
		  params.permit(:class_name, :length, :climb, :controls, :course, :filename, :file_id, :participants)
		end

		def require_have_comp
			@comp = LcComp.find_by_id(params[:comp_id])
			return response_bad_request if @comp.nil?
		end
end
