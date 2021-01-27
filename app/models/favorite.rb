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
end
