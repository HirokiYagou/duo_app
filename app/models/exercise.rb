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

  def self.update_third(id, params)
    Exercise.where(term_id: id).where(e_j: params[:e_j]).order(':updated_at DESC').firsh(3)[2]
  end
end
