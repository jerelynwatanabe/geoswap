class CheckInsController < ApplicationController

	def new
		@location = Location.find(params[:location_id])
		@check_in=@location.check_ins.build
	end
	
	def create
		@location = Location.find(params[:location_id])
		@check_in = @location.check_ins.create(params[:check_in])
		redirect_to location_check_in_path(@location, @check_in)
	end
	
	def show
		@check_in = CheckIn.find(params[:id])
	end
	
end
