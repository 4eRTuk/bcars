class ModelsController < ApplicationController
helper_method :sort_column, :sort_direction
include ApplicationHelper
before_action :manufacturers, except: [:show, :destroy]
before_action :mdl, only: [:edit, :show, :update]
before_action :signed_in_user, only: [:new, :create, :edit, :update, :index]
before_action :user_acs_level,   only: [:new, :create, :edit, :update, :index]

def index
	@models = Model.search(params[:name], params[:manufacturer_id]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
end

def edit
end

def update
	if @model.update_attributes(params.require(:model).permit(:name, :manufacturer_id))
		flash[:success] = "Данные успешно сохранены"
		redirect_to edit_model_path(@model)
	else
		render 'edit'
	end
end

def show
	@spec = @model.specifications.find(get_spec_id)
	@opts = Option.where(model_id: params[:id])
	@preps = Preparation.order(:type_id).all
end

def new
	@model = Model.new
end

def create
	@model = Model.new(params.require(:model).permit(:name, :manufacturer_id))
	
	if @model.save
		flash[:success] = "Новая модель успешно создана"
		redirect_to edit_model_path(@model)
	else
		render 'new'
	end
end

def sort_column
    Model.column_names.include?(params[:sort]) ? params[:sort] : "id"
end
  
def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end

	private
	# Get all manufacturers for select_tag
	def	manufacturers
	@mans = Hash.new
	Manufacturer.all.each do |m|
		@mans[m.name] = m.id
	end
	end
	
	def mdl
		@model = Model.find(params[:id])
	end
end