class Api::V1::LcClassesController < ApplicationController
	before_action :require_have_comp

	def index
		@classes = @comp.lc_classes.all
		render json: @classes
	end

	def show
		@class = @comp.lc_classes.find_by_id(params[:id])
		render json: @class
	end

	def create
		@class = @comp.lc_classes.build(class_params)
		render json: @class.save ? @class : @class.errors
	end

	def destroy
		@class = LcClass.find_by_id(params[:id])
		@class.destroy unless @class.nil?
		render json: @class
	end

	def update
		@class = LcClass.find_by_id(params[:id])
		render json: @class.nil? ? nil : @class.update(class_params) ? @class : @class.errors
	end

	private
		def class_params
		  params.permit(:class_name, :length, :climb, :controls, :course, :filename, :file_id, :participants)
		end

		def require_have_comp
			@comp = LcComp.find_by_id(params[:comp_id])
			if @comp.nil?
				render json: {"status": "error"}
				return
			end
		end
end
