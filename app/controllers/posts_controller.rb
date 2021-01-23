class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).order(id: "DESC")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @post = Post.create(post_params)
  end

  def destroy
    Post.destroy(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image).merge(user_id: current_user.id)
  end
end
