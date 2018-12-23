class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :update, :create_comments, :create_comments_reply]

  def index
      user_id = session[:user_id]
      @self_posts = Post.where(user_id: user_id)

      if params[:search]
        user_id = session[:user_id]
        @self_posts = Post.where(user_id: user_id)
        @self_posts = @self_posts.search(params[:search]).order("created_at DESC")
      else
        user_id = session[:user_id]
        @self_posts = Post.where(user_id: user_id)
      end
  end

  def show
    if @post.status == 'public'
      set_post
      @post.update(show: @post.show.to_i + 1)
    else
      if current_user.id == @post.user_id
        set_post
      else
        respond_to do |format|
          format.html { redirect_to '/', alert: 'Post not a public.' }
        end
      end
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    @post.show = '1'
    @post.status = 'private'
    user = User.find(session[:user_id])
    @post.tags = ["#{user.name}"]

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
      user_name = params[:comment][:user_name]
    else
      user = User.find(session[:user_id])
      user_name = user.name
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

  def create_comments_reply
    if params[:comment][:user_name]
      user_name = params[:comment][:user_name]
    else
      user = User.find(session[:user_id])
      user_name = user.name
    end
    @comments = Comment.new(
        user_name: user_name,
        body: params[:comment][:body],
        post_id: params[:post_id],
        ancestry: params[:parent_id]
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

  def create_new_tag
    if params[:post][:tag][:new]
      @post = Post.find(params[:id])
      tags = @post.tags.push(params[:post][:tag][:new])
      respond_to do |format|
        if @post.update(tags: tags)
          format.html { redirect_to @post, notice: 'Post tag was successfully created.' }
          format.json { render json: @post }
        else
          format.html { redirect_to @post, notice: 'Post tag created is failed.' }
          format.json { render json: @post.errors }
        end
      end
    end
  end

  def edit_tags
    if params[:tags]
      new_array = params[:tags].reject(&:empty?)
      @post = Post.find(params[:id])
      respond_to do |format|
        if @post.update(tags: new_array)
          format.html { redirect_to @post, notice: 'Post tags was successfully updated.' }
          format.json { render json: @post }
        else
          format.html { redirect_to @post, notice: 'Post tags updated is failed.' }
          format.json { render json: @post.errors }
        end
      end
    end
  end

  def filter_tag
    params[:tag]
  end

  def youtube_created
    if params[:post][:youtube_url]
      link_id = get_v(params[:post][:youtube_url])

      @post = Post.find(params[:id])
      respond_to do |format|
        if @post.update(video: link_id)
          format.html { redirect_to @post, notice: 'Post youtube_url was successfully updated.' }
          format.json { render json: @post }
        else
          format.html { redirect_to @post, notice: 'Post youtube_url updated is failed.' }
          format.json { render json: @post.errors }
        end
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

  def get_v(url)
    components = URI.parse(url)

    params = CGI.parse(components.query)
    params['v'].first
  end

  def set_post
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post.id)
    @comments = @comments.paginate(:page => params[:page], :per_page => 5)
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :status)
  end
end
