class IndexController < ApplicationController
  def index
    @posts = Post.all

  end
end
