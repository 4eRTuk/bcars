class CarsController < ApplicationController
	helper_method :sort_column, :sort_direction
	before_action :signed_in_user, only: [:new, :update, :create]
	before_action :user_acs_level,   only: [:update]
	
	def new
		@model = Model.find(cookies[:model])
		@spec = Specification.find(cookies[:spec])
		@engine = Engine.find(cookies[:engine])
		
		@opts_sum = 0
		if !cookies[:opts].blank?
			@opts = Option.where(id: cookies[:opts].split(","))
			@opts_sum = Option.sum(:price, :conditions => {:id => cookies[:opts].split(",")}).to_i
		end
		
		@preps_sum = 0
		if !cookies[:preps].blank?
			@preps = Preparation.find(cookies[:preps].split(","))
			@preps_sum = Preparation.sum(:price, :conditions => {:id => cookies[:preps].split(",")}).to_i
		end
		
		@car = Car.new
	end
	
	def create
		@car = Car.new(model_id: cookies[:model], specification_id: cookies[:spec], engine_id: cookies[:engine], color: cookies[:color])
		@car.price = Specification.find(cookies[:spec]).price
		@order = Order.new(car_id: @car.id, client_id: current_user.id, manager_id: 1, order_date: Time.zone.now)
				
		if !cookies[:opts].blank?
			
			
			@car.price += Option.sum(:price, :conditions => {:id => cookies[:opts].split(",")}).to_i
		end
		
		if !cookies[:preps].blank?
			
			
			@car.price += Preparation.sum(:price, :conditions => {:id => cookies[:preps].split(",")}).to_i
		end	
		
		if @car.save
			@order.car_id = @car.id+1
			if @order.save
				@order = Order.find(@order.id+1)
				
				Preparation.find(cookies[:preps].split(",")).each do |prep|
					@order.preparations << prep
				end

				Option.where(id: cookies[:opts].split(",")).each do |opt|
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
