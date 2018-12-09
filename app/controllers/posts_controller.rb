class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :update, :create_comments]

  def index
    user_id = session[:user_id]
    @self_posts = Post.where(user_id: user_id)
  end

  def show
    set_post
    @post.update(show: @post.show.to_i + 1)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    @post.show = '1'

    respond_to do |format|
      if @post.save
        format.html { redirect_to '/', notice: 'Post was successfully created.' }
        format.json { render json: @post }
      else
        format.html { redirect_to '/', alert: 'Error cant created.' }
        format.json { render json: @post.errors }
      end
    end
  end

  def create_comments
    if params[:comment][:user_name]
      user = User.find(session[:user_id])
      user_name = user.name
    else
      user_name = params[:comment][:user_name]
    end
    @comments = Comment.new(
                          user_name: user_name,
                           body: params[:comment][:body],
                           post_id: params[:post_id]
    )

    respond_to do |format|
      if @comments.save
        format.html { redirect_to "/posts/#{params[:post_id]}", notice: 'Comments successfully created.' }
        format.json { render json: @comments }
      else
        format.html { redirect_to "/posts/#{params[:post_id]}", alert: @comments.errors }
        format.json { render json: @comments.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render json: @post }
      else
        format.html { redirect_to @post, notice: 'Post updated is failed.' }
        format.json { render json: @post.errors }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to '/posts', notice: 'Post was successfully destroyed.' }
      format.json { render json: 'destroy' }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post.id)
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
