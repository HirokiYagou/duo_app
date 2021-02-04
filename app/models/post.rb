class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :post_terms, dependent: :destroy
  has_many :terms, through: :post_terms

  validates :content, presence: true, length: { maximum: 140 }
end
