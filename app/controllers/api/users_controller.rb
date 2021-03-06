class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :timeline, :profile]
  require "#{Rails.root}/app/serializers/timeline_serializer.rb"
  require "#{Rails.root}/app/serializers/user_profile_serializer.rb"
  require "#{Rails.root}/app/serializers/user_serializer.rb"

  def create
    byebug
    user = User.create(
      fullname: params[:fullname],
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password: params[:password_confirmation]
    )
    user.create_default_avatar()
    Progress.create(user_id: user.id, published: false)
    if user.valid?
      render json: {user: UserSerializer.new(user).serialize_as_json, token: issue_token({ user_id: user.id }), status: 201}
    else
      render json: {errors: user.errors.full_messages, status: 400}
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {user: UserSerializer.new(user).serialize_as_json, token: issue_token({ user_id: user.id }), status: 200}
    else
      render json: {errors: "Email or password incorrect", status: 400}
    end
  end

  def show
    if @user
      render json: {user: UserSerializer.new(@user).serialize_as_json, status: 200}
    else
      render json: {user: @user.errors.full_messages, status: 400}
    end
  end

  def update
    byebug
    @user.update(
      fullname: params[:fullname],
      username: params[:username],
      email: @user.email,
    )
    byebug
    @user.avatar.purge
    byebug
    @user.avatar.attach(params[:file])
    byebug
    if @user
      render json: {user: UserSerializer.new(@user).serialize_as_json, status: 200}
    else
      render json: {message: @user.errors.full_messages, status: 400}
    end
  end

  def destroy
    @user.destroy
    render json: {message: "Deleted user", status: 204}
  end

  def timeline
    current_user = set_current_user()
    render json: {timeline: TimelineSerializer.new(current_user).serialize_as_json, status: 200}
  end

  def search
    @users = User.search_for_users(params[:search_term]).map{ |user| UserSerializer.new(user).serialize_as_json() }
    if @users
      render json: {results: @users, status: 200}
    else
      render json: {message: "Search term did not match any users", status: 404}
    end
  end

  def validate
    if logged_in
      render json: {user: UserSerializer.new(@current_user).serialize_as_json(), token: issue_token({ user_id: @current_user.id }), status: 200}
    else
      render json: {errors: "Invalid token", status: 403}
    end
  end

  def profile
    current_user = set_current_user()
    if @user
      render json: {profile: UserProfileSerializer.new(@user, current_user).serialize_as_json, status: 200}
    else
      render json: {errors: "User not does not exist", status: 404}
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :fullnameviewable, :username, :email, :password, :password_confirmation, :gender, :city, :cityviewable, :about)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end