class Api::V1::LcCompsController < ApplicationController
	def index
		lccomps = LcComp.where("name = ?", params[:name]).order(created_at: :desc)
		render json: lccomps
		# render json: { status: 'SUCCESS', message: 'loaded lccomps', data: lccomps }
	end

	def show
		lccomp = LcComp.find(params[:id])
		render json: { status: 'SUCCESS', message: 'loaded lccomp', data: lccomp }
	end

	def create
		lccomp = LcComp.new(lccomp_params)
		if lccomp.save
			render json: { status: 'SUCCESS', message: 'saved', data: lccomp }
		else
			render json: { status: 'ERROR', message: 'not saved', data: lccomp.errors }
		end
	end

	def destroy
		lccomp = LcComp.find(params[:id])
		lccomp.destroy
		render json: { status: 'SUCCESS', message: 'deleted', data: lccomp }
	end

	def update
		lccomp = LcComp.find(params[:id])
		if lccomp.update(lccomp_params)
			render json: { status: 'SUCCESS', message: 'updated', data: lccomp }
		else
			render json: { status: 'ERROR', message: 'not updated', data: lccomp }
		end
	end

	private
		def lccomp_params
		  params.permit(:name, :date, :terrain, :owner, :link, :lc_link)
		end
end
