class UsersController < ApplicationController
  def index
  end

  def search
    @users = User.search(params[:keyword])
  end
end
