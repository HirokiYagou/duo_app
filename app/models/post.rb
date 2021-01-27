class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, length: { maximum: 140 }

  def self.post_create(params)
    post = Post.create(params)
    if params[:reply_to]
      to_post = Post.find(params[:reply_to])
      to_post.update(replied_count: to_post[:replied_count] += 1)
    end
    return post
  end
end
