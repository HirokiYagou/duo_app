class AddPostidToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :reply_to, :integer
  end
end
