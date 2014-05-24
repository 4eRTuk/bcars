class PeopleController < ApplicationController
helper_method :sort_column, :sort_direction
include ApplicationHelper
	before_action :signed_in_user, only: [:edit, :update, :index, :show]
	before_action :correct_user,   only: [:edit, :update, :show]
	before_action :user_acs_level,   only: [:index]

def index
	@people = Person.search(params[:id], params[:email], params[:firstname], params[:lastname], params[:middlename], params[:phone]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
end
	
def new
	@person = Person.new
end

def create
	@person = Person.new(person_params)
	
	if @person.save
		sign_in @person
		flash[:success] = "Аккаунт успешно создан"
		redirect_to person_path(@person.id-1)
	else
		render 'new'
	end
end

def edit
end

def update
	if @person.update_attributes(person_params)
		flash[:success] = "Данные успешно сохранены"
		redirect_to person_path(@person.id)
	else
		render 'edit'
	end
end

def show
	@person = Person.find(params[:id])
end

private 
def person_params
	params.require(:person).permit(:firstname, :middlename, :lastname, :dob, :email, :password, :password_confirmation, :gender, :phone)
end

def sort_column
    Person.column_names.include?(params[:sort]) ? params[:sort] : "id"
end
  
def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end

end
