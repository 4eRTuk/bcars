class SessionsController < ApplicationController
	before_action :not_signed, only: [:new, :create]

def new
end

def create
	person = Person.find_by(email: params[:session][:email].downcase)
	if person && person.authenticate(params[:session][:password])
		sign_in person
		redirect_back_or person
	else
		flash.now[:error] = "Неверный пароль или логин!"
		render 'new'
	end
end

def destroy
	sign_out
    redirect_to root_url
end

	private
	
	def	not_signed
		redirect_to person_path(current_user), notice: "Сначала нужно выйти из текущего аккаунта!" unless !signed_in?
	end

end
