class Admin::TermsController < ApplicationController
  before_action :valify_admin

  def index
  end

  private

  def valify_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
