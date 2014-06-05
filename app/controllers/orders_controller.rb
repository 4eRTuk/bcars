class OrdersController < ApplicationController
helper_method :sort_column, :sort_direction
include ApplicationHelper
before_action :statuses, only: [:show, :index]
before_action :ord, only: [:show, :update, :addopt, :addprep, :remopt, :remprep]
before_action :signed_in_user, only: [:index, :show, :update, :addopt, :addprep, :remopt, :remprep]
before_action only: [:index, :show] do
	user_acs_level 1
end
before_action only: [:update, :addopt, :addprep, :remopt, :remprep] do
	user_acs_level 99
end

def index
@orders = Order.search(params[:status_id], params[:q]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
end

def show
	@preps = @order.preparations	
	
	@options = Hash.new
	Model.find(@order.car.model.id).options.where.not(id: @order.options.pluck(:id)).each do |m|
		@options[m.name] = m.id
	end
	
	@preparations = Hash.new
	Preparation.all.where.not(id: @order.preparations.pluck(:id)).each do |m|
		@preparations[m.name] = m.id
	end
	
	@country = Hash.new
	Country.all.each do |m|
		@country[m.name] = m.id
	end
end

def update
	if @order.update_attributes(params.require(:order).permit(:status_id, :execution_date))
		flash[:success] = "Данные успешно сохранены"
		redirect_to @order
	else
		render 'show'
	end
end

def addopt
	opt = Option.find(params[:option_id])
	@order.options << opt
	@order.car.update_attribute(:price, @order.car.price + opt.price)
	flash[:success] = "Добавлено"
	redirect_to @order
end

def addprep
	prep = Preparation.find(params[:prep_id])
	@order.preparations << prep
	@order.car.update_attribute(:price, @order.car.price + prep.price)
	flash[:success] = "Добавлено"
	redirect_to @order
end

def remopt
	opt = Option.find(params[:option_id])
	@order.options.delete(opt)
	@order.car.update_attribute(:price, @order.car.price - opt.price)
	flash[:success] = "Удалено"
	redirect_to @order
end

def remprep
	prep = Preparation.find(params[:prep_id])
	@order.preparations.delete(prep)
	@order.car.update_attribute(:price, @order.car.price - prep.price)
	flash[:success] = "Удалено"
	redirect_to @order
end

def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : "status_id"
end
  
def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end

	private
	
	def ord
		@order = Order.find(params[:id])
	end
	
	def statuses
		@status = Hash.new
		Status.all.each do |m|
			@status[m.status] = m.id
		end
	end
end
