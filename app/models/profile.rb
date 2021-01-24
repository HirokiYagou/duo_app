class Profile < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :icon
  has_one_attached :header

  validates :nickname, presence: true, length: { maximum: 50 }
  validates :status, length: { maximum: 160 }
end
