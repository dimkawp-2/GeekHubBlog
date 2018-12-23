class IndexController < ApplicationController
  def index
    @posts = Post.all
    @posts = @posts.paginate(:page => params[:page], :per_page => 5)
  end
end
