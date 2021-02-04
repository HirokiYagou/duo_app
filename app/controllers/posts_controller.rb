class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).order(id: "DESC")
    @reply_data = Post.group(:reply_to).count
    @favorite_data = Favorite.group(:post_id).count
    user = User.find(current_user.id)
    @post_ids = Favorite.get_favorites_post_id(user)
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

  def search
    @terms = Term.search(params[:keyword])
  end

  def check_favorite
    user = User.find(current_user.id)
    Favorite.click(user, params[:id])
    post = Post.find(params[:id])
    @count = post.favorites.length
  end

  def get_favorites
    user = User.find(params[:id])
    @post_ids = Favorite.get_favorites_post_id(user)
  end



  private

  def post_params
    params.require(:post).permit(:content, :image, :reply_to, term_ids: []).merge(user_id: current_user.id)
  end
end
