class SpecificationsController < ApplicationController
before_action :speca, only: [:edit, :update, :rem, :add]
before_action :mdl
before_action :signed_in_user, only: [:edit, :update, :new, :create, :add, :rem]
before_action only: [:edit, :new] do
	user_acs_level 1
end
before_action only: [:update, :create, :add, :rem] do
	user_acs_level 99
end

def edit
end

def update
	if @spec.update_attributes(params.require(:specification).permit(:name, :info, :price))
		flash[:success] = "Данные успешно сохранены"
		redirect_to edit_specification_path(@spec)
	else
		render 'edit'
	end
end

def add
	eng = Engine.find(params[:engine_id])
	@spec.engines << eng
	flash[:success] = "Добавлено"
	redirect_to edit_specification_path(@spec)
end

def rem
	eng = Engine.find(params[:engine_id])
	@spec.engines.delete(eng)
	flash[:success] = "Удалено"
	redirect_to edit_specification_path(@spec)
end

def new
	@spec = Specification.new
	mdl = cookies[:model_id] unless cookies[:model_id].blank?
	mdl = params[:model_id] unless params[:model_id].blank?
	
	if mdl.blank? || !mdl.to_i.is_a?(Integer)
		flash[:error] = "Не выбрана модель! #{mdl}"
		render 'new'
	else
		@spec.model_id = mdl
		cookies[:model_id] = mdl
	end
	
	@mname = Model.find(mdl).name unless mdl.blank?
end

def create
	@spec = Specification.new(params.require(:specification).permit(:name, :info, :price, :model_id))
	@spec.model_id = cookies[:model_id]
	
	if @spec.save
		flash[:success] = "Новая комплектация #{@spec.id} успешно создана"
		redirect_to edit_specification_path(@spec.id)
		cookies.delete(:model_id)
	else
		render 'new'
	end
end

	private
	
	def mdl
		@models = Hash.new
		Model.all.each do |m|
			@models[m.name] = m.id
		end
	end
	
	def speca
		@spec = Specification.find(params[:id])
		
		@engines = Hash.new
		Engine.where.not(id: @spec.engines.pluck(:id)).each do |e|
			@engines[e.info] = e.id
		end
	end
end
