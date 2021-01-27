class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, length: { maximum: 140 }

  def self.reply_count(to_id)
    if to_id
      to_post = Post.find(to_id)
      if to_post[:reply_count]
        to_post.update(replied_count: to_post[:replied_count] += 1)
      else
        to_post.update(replied_count: 1)
      end
    end
  end
  
  def self.destroy_reply(post_id)
    post = Post.find(post_id)
    if post[:reply_to]
      to_post = Post.find(post[:reply_to])
      to_post.update(replied_count: to_post[:replied_count] -= 1)
    end
  end
end
