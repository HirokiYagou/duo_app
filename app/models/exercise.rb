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
    user = User.find(params[:user_id])
    third_record = user.exercises.where(term_id: id).where(e_j: params[:e_j]).order('updated_at DESC').first(3)[2]
    if third_record
      third_record.update(params.merge(term_id: id))
    else
      Exercise.create(params.merge(term_id: id))
    end
  end
end
