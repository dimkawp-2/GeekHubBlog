class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, :only => :create

  def index
    @users = User.all
  end

  def show
    @posts = Post.where(user_id: session[:user_id]) # session[:id]
  end

  def new
    @user = User.new
  end

  def profile
    @user = User.find(session[:user_id])
    @posts = Post.where(user_id: session[:user_id])
  end
  def create
    @user = User.new(user_params) # params[:user]
    if params[:user][:email] == 'dimkawp@gmail.com'
      @user.role = 'admin'
    else
      @user.role = 'user'
    end


    respond_to do |format|
      if @user.save
        format.html { redirect_to '/', notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to '/', alert: 'User cannot created.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
