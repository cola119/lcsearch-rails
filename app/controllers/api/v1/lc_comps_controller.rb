class Api::V1::LcCompsController < ApplicationController
	def search
		@comps = params[:name].nil? ? nil : LcComp.where("name LIKE ?", '%'+params[:name]+'%').order(created_at: :desc)
		render json: @comps
	end

	def index
		@comps = LcComp.order(created_at: :desc)
		# @comps = LcComp.where("name = ?", params[:name]).order(created_at: :desc)
		render json: @comps
	end

	def show
		@comp = LcComp.find_by_id(params[:id])
		render json: @comp
	end

	def create
		@comp = LcComp.new(comp_params)
		render json: @comp.save ? @comp : @comp.errors
	end

	def destroy
		@comp = LcComp.find_by_id(params[:id])
		@comp.destroy unless @comp.nil?
		render json: @comp
	end

	def update
		@comp = LcComp.find_by_id(params[:id])
		render json: @comp.nil? ? nil : @comp.update(comp_params) ? @comp : @comp.errors
	end

	private
		def comp_params
		  params.permit(:name, :date, :terrain, :owner, :link, :lc_link)
		end
end
