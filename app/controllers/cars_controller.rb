class CarsController < ApplicationController
	helper_method :sort_column, :sort_direction
	before_action :signed_in_user, only: [:new, :update, :create]
	before_action only: [:update] do
		user_acs_level 99
	end
	
	def new
		@model = Model.find(cookies[:model])
		@spec = Specification.find(cookies[:spec])
		@engine = Engine.find(cookies[:engine])
		
		@opts_sum = 0
		if !cookies[:opts].blank?
			ids = Array.new
			cookies[:opts].split(",").each do |o|
				ids << o.to_i
			end
			
			@opts = Option.where(id: ids)
			@opts_sum = Option.where(id: ids).sum(:price).to_i
		end
		
		@preps_sum = 0
		if !cookies[:preps].blank?
			ids = Array.new
			cookies[:preps].split(",").each do |o|
				ids << o.to_i
			end
			
			@preps = Preparation.find(ids)
			@preps_sum = Preparation.where(id: ids).sum(:price).to_i
		end
		
		@car = Car.new
	end
	
	def create
		@car = Car.new(model_id: cookies[:model], specification_id: cookies[:spec], engine_id: cookies[:engine], color: cookies[:color])
		@car.price = Specification.find(cookies[:spec]).price
		@order = Order.new(car_id: @car.id, client_id: current_user.id, order_date: Time.zone.now)
		
		if !cookies[:opts].blank?
			ids = Array.new
			cookies[:opts].split(",").each do |o|
				ids << o.to_i
			end
			
			@car.price += Option.where(id: ids).sum(:price).to_i
		end
		
		if !cookies[:preps].blank?
			ids = Array.new
			cookies[:preps].split(",").each do |o|
				ids << o.to_i
			end
			
			@car.price += Preparation.where(id: ids).sum(:price).to_i
		end	
		
		if @car.save
			@order.car_id = @car.id
			if @order.save
				Preparation.find(cookies[:preps].split(",")).each do |prep|
					@order.preparations << prep
				end

				Option.find(cookies[:opts].split(",")).each do |opt|
					@order.options << opt
				end

				redirect_to current_user
			else
				flash[:error] = "Ошибка создания заказа! Обратитесь в ТП."
				render 'new'
			end
		else
			flash[:error] = "Ошибка создания заказа! Обратитесь в ТП."
			render 'new'
		end
	end
	
	def update
		@car = Car.find(params[:id])
		if @car.update_attributes(params.require(:car).permit(:color, :assembling_date, :country_id, :pts))
			flash[:success] = "Данные успешно сохранены"
		else
			flash[:error] = "Ошибка сохранения!"
		end
		
		redirect_to orders_path
	end

	private
	
	def car_params
		params.require(:car).permit(:model_id, :specification_id, :engine_id)
    end
	
	def sort_column
		Car.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end
  
	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
	end
end
