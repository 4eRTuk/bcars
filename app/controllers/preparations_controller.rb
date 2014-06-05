class PreparationsController < ApplicationController
before_action :preps, only: [:edit, :update]
before_action :tps, only: [:edit, :update, :new, :create]
before_action :signed_in_user, only: [:edit, :update, :index, :new, :create]
before_action only: [:edit, :index, :new] do
	user_acs_level 1
end
before_action only: [:update, :create] do
	user_acs_level 99
end

def index
@preps = Preparation.all
end

def edit
end

def update
	if @prep.update_attributes(params.require(:preparation).permit(:name, :info, :price, :type_id))
		flash[:success] = "Данные успешно сохранены"
		redirect_to edit_preparation_path(@prep)
	else
		render 'edit'
	end
end

def new
	@prep = Preparation.new
end

def create
	@prep = Preparation.new(params.require(:preparation).permit(:name, :info, :price, :type_id))
	
	if @prep.save
		flash[:success] = "Новая услуга успешно создана"
		redirect_to edit_preparation_path(@prep.id)
	else
		render 'new'
	end
end

	private
	
	def tps
		@types = Hash.new
		TypeOfPreparation.all.each do |m|
			@types[m.name] = m.id
		end
	end
	
	def preps
		@prep = Preparation.find(params[:id])
	end
end
