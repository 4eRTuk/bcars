module SessionsHelper

def sign_in(user)
    remember_token = Person.new_remember_token
	cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Person.encrypt(remember_token))
    self.current_user = user
end

def signed_in?
    !current_user.nil?
end

def sign_out
    current_user.update_attribute(:remember_token, Person.encrypt(Person.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
end

def signed_in_user
	store_location
	redirect_to signin_url, notice: "Требуется авторизация." unless signed_in?
end

def correct_user
    @person = Person.find(params[:id])
	
	if current_user.acs_level == 0 && !current_user?(@person)
		flash[:notice] = "У вас нет доступа к этой странице!"
		redirect_to(root_url)
	end
end

def user_acs_level
    if current_user.acs_level == 0
		flash[:notice] = "У вас нет доступа к этой странице!"
		redirect_to(root_url)
	end
end

def current_user=(user)
    @current_user = user
end

def current_user
    remember_token = Person.encrypt(cookies[:remember_token])
    @current_user ||= Person.find_by(remember_token: remember_token)
end

def current_user?(user)
    user == current_user
end

def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
end

def store_location
	session[:return_to] = request.url if request.get?
end

end
