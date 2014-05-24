class OptionsController < ApplicationController
before_action :preps, only: [:edit, :update]
before_action :tps, only: [:edit, :update, :new, :create]
before_action :signed_in_user, only: [:edit, :update, :new, :create]
before_action :user_acs_level,   only: [:edit, :update, :new, :create]

def edit
end

def update
	if @opt.update_attributes(params.require(:option).permit(:name, :info, :price, :type_id))
		flash[:success] = "Данные успешно сохранены"
		redirect_to edit_option_path(@opt)
	else
		render 'edit'
	end
end

def new
	@opt = Option.new
	
	mdl = cookies[:model_id] unless cookies[:model_id].blank?
	mdl = params[:model_id] unless params[:model_id].blank?
	
	if mdl.blank? || !mdl.to_i.is_a?(Integer)
		flash[:error] = "Не выбрана модель!"
		render 'new'
	else
		@opt.model_id = mdl
		cookies[:model_id] = mdl
	end
	
	@mname = Model.find(mdl).name unless mdl.blank?
end

def create
	@opt = Option.new(params.require(:option).permit(:name, :info, :price, :type_id))
	@opt.model_id = cookies[:model_id]
	
	if @opt.save
		flash[:success] = "Новая оцпия успешно создана"
		redirect_to edit_option_path(@opt.id+1)
		cookies.delete(:model_id)
	else
		render 'new'
	end
end

	private
	
	def tps
		@types = Hash.new
		TypeOfOption.all.each do |m|
			@types[m.name] = m.id
		end
	end
	
	def preps
		@opt = Option.find(params[:id])
	end
end
