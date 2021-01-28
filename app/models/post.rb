class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy

  validates :content, presence: true, length: { maximum: 140 }
end
