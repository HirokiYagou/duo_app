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
      if third_record[:score] == params[:score].to_i
        third_record.destroy
        Exercise.create(params.merge(term_id: id))
      else
        third_record.update(params.merge(term_id: id))
      end
    else
      Exercise.create(params.merge(term_id: id))
    end
  end

  def self.search_exercises(lesson, user, e_j, type)
    if type == 'sentence'
      terms = Term.includes(:exercises).where(lesson: lesson).where(word_id: 0)
    elsif type == 'word'
      terms = Term.includes(:exercises).where(lesson: lesson).where("word_id > 0")
    end
    exercises = []
    terms.each do |term|
      term.exercises.where(user_id: user.id).where(e_j: e_j).order('updated_at  ASC').each do |exercise|
        exercises << exercise
      end
    end
    return exercises
  end
end
