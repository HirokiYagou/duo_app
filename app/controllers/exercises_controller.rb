class ExercisesController < ApplicationController
  before_action :set_user, only: [
    :sentence_english_scores,
    :sentence_japanese_scores,
    :word_english_scores,
    :word_japanese_scores
  ]

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

  def sentence_english_scores
    @exercises = Exercise.search_exercises(params[:id], @user, 0, 'sentence')
  end
  
  def sentence_japanese_scores
    @exercises = Exercise.search_exercises(params[:id], @user, 1, 'sentence')
    render :sentence_english_scores
  end
  
  def word_english_scores
    @exercises = Exercise.search_exercises(params[:id], @user, 0, 'word')
    render :sentence_english_scores
  end
  
  def word_japanese_scores
    @exercises = Exercise.search_exercises(params[:id], @user, 1, 'word')
    render :sentence_english_scores
  end
  
  private
  
  def exercise_params
    params.require(:exercise).permit(:e_j, :score).merge(user_id: current_user.id)
  end
  
  def set_user
    @user = User.find(current_user.id)
  end
end
