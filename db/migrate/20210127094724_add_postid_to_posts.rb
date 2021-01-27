class AddPostidToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :post_id, :integer
  end
end
