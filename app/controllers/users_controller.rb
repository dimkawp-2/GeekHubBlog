class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: :create

  def admin
    if !current_user || current_user.role != 'admin'
      redirect_to '/', alert: 'You not admin status.'
    else
      @users = User.all
    end
  end

  def show
    @posts = Post.where(user_id: session[:user_id]) # session[:id]
  end

  def new
    @user = User.new
  end

  def profile
    if current_user
      @user = User.find(session[:user_id])
      @posts = Post.where(user_id: session[:user_id])
    else
      redirect_to '/', notice: 'You need authentication.'
    end

  end

  def create
    @user = User.new(user_params)
    @user.role = 'user'

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/', notice: 'User was successfully created.' }
        format.json { render json: @user.name }
      else
        format.html { redirect_to '/', alert: 'User cannot created.' }
        format.json { render json: @user.errors }
      end
    end
  end

  def update
    if params[:user][:role]
      @user.update(role: params[:user][:role])
      respond_to do |format|
        format.html { redirect_to '/admin', notice: 'ROLE was successfully updated.' }
        format.json { render json: @user }
      end
    else
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to '/profile', notice: 'NAME was successfully updated.' }
          format.json { render json: @user }
        else
          format.html { redirect_to '/profile', notice: 'NAME updated is failed.' }
          format.json { render json: @user.errors }
        end
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/admin', notice: 'User was successfully destroyed.' }
      format.json { render json: 'destroy' }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
