class ExercisesController < ApplicationController
  def index
  end

  def update
    Exercise.update_third(params[:id], exercise_params)
  end
  
  def get_sentences
    questions = Term.where(lesson: params[:id]).where(word_id: 0)
    render json: { questions: questions }
  end

  def get_words
    questions = Term.where(lesson: params[:id]).where("word_id > 0")
    render json: { questions: questions }
  end

  private

  def exercise_params
    params.require(:exercise).permit(:e_j, :score).merge(user_id: current_user.id)
  end
end
