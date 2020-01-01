class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :timeline, :profile]
  require "#{Rails.root}/app/serializers/timeline_serializer_test.rb"
  require "#{Rails.root}/app/serializers/user_profile_serializer.rb"
  require "#{Rails.root}/app/serializers/user_serializer.rb"

  def create
    user = User.create(user_params)
    user.create_default_avatar()
    Progress.create(user_id: user.id, published: false)
    if user.valid?
      render json: {user: UserSerializer.new(user).serialize_as_json, token: issue_token({ user_id: user.id })}
    else
      render json: { errors: user.errors.full_messages, status: :not_accepted }
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: { user: UserSerializer.new(user).serialize_as_json, token: issue_token({ user_id: user.id }) }
    else
      render json: { errors: "Email or password incorrect", status: :not_accepted }
    end
  end

  def show
    render json: { user: UserSerializer.new(@user).serialize_as_json }
  end

  def update
    @user.safe_update(params)
    if @user
      render json: { user: UserSerializer.new(@user).serialize_as_json, message: "Updated profile picture" }
    else
      render json: { message: @user.errors.full_messages, status: :not_accepted}
    end
  end

  def destroy
    @user.destroy
    render json: { message: "Deleted user", status: :ok}
  end

  def timeline
    current_user = set_current_user()
    render json: { timeline: TimelineSerializerTest.new(current_user).serialize_as_json }
  end

  def follow
    current_user = set_current_user()
    render json: { message: "Deleted user", status: :ok}
  end

  def search
    @users = User.search_for_users(params[:search_term]).map{ |user| UserSerializer.new(user).serialize_as_json() }
    if @users
      render json: { results: @users, message: "Users found"}
    else
      render json: {  message: "Search term did not match any users"}
    end
  end

  def validate
    if logged_in
      render json: { user: UserSerializer.new(@current_user).serialize_as_json(), token: issue_token({ user_id: @current_user.id }) }
    else
      render json: { errors: "Invalid token", status: :not_accepted}
    end
  end

  def profile
    current_user = set_current_user()
    if @user
      render json: { profile: UserProfileSerializer.new(@user, current_user).serialize_as_json }
    else
      render json: { errors: "User not does not exist", status: :not_accepted}
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :fullnameviewable, :username, :email, :password, :password_confirmation, :gender, :city, :cityviewable, :about, :avatar)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end