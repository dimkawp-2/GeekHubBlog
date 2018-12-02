class SessionController < ApplicationController

  def new
  end

  def create
    if params[:user][:email].blank? || params[:user][:password].blank?
      redirect_to '/', alert: 'Miss email or password.'
    else
      user = User.find_by email: params[:user][:email]
      @posts = Post.all
      if user.email == params[:user][:email] && user.password == params[:user][:password]
        session[:user_id] = user.id
        redirect_to '/', notice: 'Login successfully created.'
      else
        redirect_to '/', alert: 'Login error.'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: 'logout successfully.'
  end
end
