class SessionController < ApplicationController
  def create
    user = User.find_by email: params[:user][:email]
    if user
      user.email == params[:user][:email] && user.password == params[:user][:password]
      session[:user_id] = user.id
      redirect_to '/', notice: 'Login successfully created.'
    else
      redirect_to '/', alert: 'Login error.'
    end
  end
end
