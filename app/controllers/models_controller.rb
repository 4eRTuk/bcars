class ModelsController < ApplicationController
helper_method :sort_column, :sort_direction
include ApplicationHelper
before_action :manufacturers, except: [:show, :destroy]
before_action :mdl, only: [:edit, :show, :update, :upload, :serve]
before_action :signed_in_user, only: [:new, :create, :edit, :update, :index, :upload]
before_action only: [:new, :edit, :index] do
	user_acs_level 1
end
before_action only: [:create, :update, :upload] do
	user_acs_level 99
end

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
	@spec = @model.specifications.find(get_spec_id) unless @model.specifications.count == 0
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
		redirect_to edit_model_path(@model.id)
	else
		render 'new'
	end
end

def upload
	if params[:data]
		@model.data = params[:data].read
		@model.filename = params[:data].original_filename
		@model.mime_type = params[:data].content_type
	end
	
	if @model.save
		flash[:success] = "Фото добавлено"
		redirect_to edit_model_path(@model.id)
	else
		render 'new'
    end
end

def serve
    send_data(@model.data, :type => @model.mime_type, :filename => "#{@model.filename}.jpg", :disposition => "inline")
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