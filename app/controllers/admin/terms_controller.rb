class Admin::TermsController < ApplicationController
  before_action :valify_admin

  def set_term
  end

  private

  def valify_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
