class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.click(user, post_id)
    favorite = user.favorites.find_by(post_id: post_id)
    if favorite.nil?
      Favorite.create(user_id: user.id, post_id: post_id)
    else
      Favorite.destroy(favorite.id)
    end
  end

  def self.get_favorites_post_id(user)
    favorites = user.favorites
    post_ids = []
    favorites.each do |favorite|
      post_ids << favorite[:post_id]
    end
    return post_ids
  end
end
