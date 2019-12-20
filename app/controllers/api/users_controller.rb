class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :timeline, :profile]
  require "#{Rails.root}/app/serializers/timeline_serializer_test.rb"
  require "#{Rails.root}/app/serializers/user_profile_serializer.rb"

  def create
    user = User.create(
      fullname: params[:fullname],
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.valid?
      render json: {user: UserSerializer.new(user), token: issue_token({ user_id: user.id })}
    else
      render json: { errors: user.errors.full_messages, status: :not_accepted }
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: { user: UserSerializer.new(user), token: issue_token({ user_id: user.id }) }
    else
      render json: { errors: "Email or password incorrect", status: :not_accepted }
    end
  end

  def show
    render json: { user: UserSerializer.new(@user) }
  end

  def update
    if @user.update(user_params)
      render json: { user: UserSerializer.new(@user), message: "Updated user details", status: :ok}
    else
      render json: { message: @user.errors.full_messages, status: :not_accepted}
    end
  end

  def destroy
    @user.destroy
    render json: { message: "Deleted user", status: :ok}
  end

  def timeline
    current_user = set_current_user
    render json: { timeline: TimelineSerializerTest.new(current_user).serialize_as_json }
  end

  def follow
    current_user = set_current_user
    render json: { message: "Deleted user", status: :ok}

  end

  def validate
    if logged_in
      render json: { user: UserSerializer.new(@current_user), token: issue_token({ user_id: @current_user.id }) }
    else
      render json: { errors: "Invalid token", status: :not_accepted}
    end
  end

  def profile
    current_user = set_current_user
    if @user
      render json: { profile: UserProfileSerializer.new(@user, current_user).serialize_as_json }
    else
      render json: { errors: "User not does not exist", status: :not_accepted}
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :username, :email, :password)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end