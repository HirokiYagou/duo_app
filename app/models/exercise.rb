class Exercise < ApplicationRecord
  belongs_to :user
  belongs_to :term

  with_options presence: true do
    validates :e_j, numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 1
    }
    validates :score, numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 2
    }
  end
end
