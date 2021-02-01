class ExercisesController < ApplicationController
  before_action :set_user, only: [
    :sentence_english_scores,
    :sentence_japanese_scores,
    :word_english_scores,
    :word_japanese_scores
  ]

  def index
    respond_to do |format|
      format.html
      format.json
    end
  end

  def update
    Exercise.update_third(params[:id], exercise_params)
  end

  def get_sentences
    @questions = Term.where(lesson: params[:id]).where(word_id: 0)
  end

  def get_words
    @questions = Term.where(lesson: params[:id]).where("word_id > 0")
    render :get_sentences
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

  def play_voice
    # Synthesizes speech from the input string of text or ssml.
    # Note: ssml must be well-formed according to:
    # https://www.w3.org/TR/speech-synthesis/

    require "google/cloud/text_to_speech"

    # Instantiates a client
    client = Google::Cloud::TextToSpeech.text_to_speech

    # Set the text input to be synthesized
    synthesis_input = { text: "Jennifer deceived me!" }

    # Build the voice request, select the language code ("en-US") and the ssml
    # voice gender ("neutral")
    voice = {
      language_code: "en-US",
      ssml_gender:   "NEUTRAL"
    }

    # Select the type of audio file you want returned
    audio_config = { audio_encoding: "MP3" }

    # Perform the text-to-speech request on the text input with the selected
    # voice parameters and audio file type
    response = client.synthesize_speech(
      input:        synthesis_input,
      voice:        voice,
      audio_config: audio_config
    )

    # The response's audio_content is binary.
    File.open "./public/output.mp3", "wb" do |file|
      # Write the response to the output file.
      file.write response.audio_content
    end

    puts "Audio content written to file './output.mp3'"
  end
  
  private
  
  def exercise_params
    params.require(:exercise).permit(:e_j, :score).merge(user_id: current_user.id)
  end
  
  def set_user
    @user = User.find(current_user.id)
  end
end
