class PostsController < ApplicationController
  respond_to :html, :json
  include ExhibitsHelper

  def new
    @post = @blog.new_post
  end

  def create
    @post = @blog.new_post(post_params)
    if @post.publish
      redirect_to root_path, notice: 'Post added!'
    else
      render 'new'
    end
  end

  def show
    @post = exhibit(Post.find(params[:id]), self)
    respond_with(@post)
  end

  protected

  def post_params
    params.require(:post).permit(:pubdate, :title, :body, :image_url)
  end
end