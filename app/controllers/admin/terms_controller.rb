class Admin::TermsController < ApplicationController
  before_action :valify_admin

  def index
  end

  def create
    Term.create(term_params)
  end

  private

  def valify_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def term_params
    params.require(:term).permit(:sentence_id, :word_id, :lesson, :english, :japanese)
  end
end
