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
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    @post = Post.find(params[:id])
    render :create
  end

  def destroy
    Post.destroy(params[:id])
  end

  def get_profile
    @profile = Profile.where(user_id: params[:id])[0]
  end

  def update_profile
    profile = Profile.where(user_id: params[:id])[0]
    profile.update(profile_params)
  end

  private

  def post_params
    params.require(:post).permit(:content, :image).merge(user_id: current_user.id)
  end

  def profile_params
    params.require(:profile).permit(:nickname, :status, :icon, :header)
  end
end
