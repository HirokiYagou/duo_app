class ExercisesController < ApplicationController
  def index
  end

  def get_sentences
    questions = Term.where(lesson: params[:id]).where(word_id: 0)
    render json: { questions: questions }
  end

  def get_words
    questions = Term.where(lesson: params[:id]).where("word_id > 0")
    render json: { questions: questions }
  end
end
