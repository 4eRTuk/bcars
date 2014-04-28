class CarsController < ApplicationController
	def show
		@car = Car.find(params[:id])
	end
	
	def index
		@cars = Car.all
	end
end
