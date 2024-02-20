class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show]
  # before_action :authenticate_request
  
  def show
    user = User.find_by(username: params[:username])
    @profile = user.profile
    render json: ProfileBlueprint.render(@profile, view: :normal), status: :ok
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_param
    params.permit(:bio)
  end
end

