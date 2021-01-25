class Admin::TermsController < ApplicationController
  before_action :valify_admin

  def index
  end

  def create
    binding.pry
    Term.create(term_params)
  end

  private

  def valify_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def term_params
    params.require(:term).permit(:term_type, :each_id, :lesson, :english, :japanese)
  end
end
