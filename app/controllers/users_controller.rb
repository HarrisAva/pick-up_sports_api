class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]
    #  before_action :authenticate_request, only: [:index, :show, :update, :destroy]
    before_action :authenticate_request, except: [:index]

  def index
    users = User.all 

    render json: users, status: 200
  end

  def show
    @user = User.find(params[:id])

     render json: UserBlueprint.render(@user, view: :extend), status: 200
    # render json: UserBlueprint.render(@user, view: :profile), status: 200  # see profiles that include location, event, post, see user_blueprint
  end

  def create
    user = User.create(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    #user = User.find(params[:id])
    if
      @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: nil, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
 
  def posts_index
    user = User.find(params[:user_id])
    user_posts = user.posts

    render json: user_posts, status: :ok
  end
  private

  def set_user # need @ as the variable to be accessed in Update and Destroy
    @user = User.find(params[:id])
  end
  def user_params
    params.permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)

  end
end
