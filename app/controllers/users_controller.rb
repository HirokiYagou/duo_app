class UsersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    @users = User.search(params[:keyword])
  end

  def get_profile
    @profile = Profile.where(user_id: params[:id])[0]
  end

  def update_profile
    profile = Profile.where(user_id: params[:id])[0]
    profile.update(profile_params)
  end

  private

  def profile_params
    params.require(:profile).permit(:nickname, :status, :icon, :header)
  end
end
