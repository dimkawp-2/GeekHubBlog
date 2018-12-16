class SessionController < ApplicationController
  def create
    user = User.find_by email: params[:user][:email]
    if user
      if user.role == 'baned'
        redirect_to '/', alert: 'Login error your are baned.'
      else
        user.email == params[:user][:email] && user.password == params[:user][:password]
        session[:user_id] = user.id
        redirect_to '/', notice: 'Login successfully created.'
      end
    else
      redirect_to '/', alert: 'Login error.'
    end
  end
end
