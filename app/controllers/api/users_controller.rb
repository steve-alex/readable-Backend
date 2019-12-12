class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :timeline]

  def create
    user = User.create(user_params)
    if user.valid?
      render json: { user: UserSerializer.new(user), token: issue_token({ user_id: user.id }) }
    else
      render json: { errors: user.errors.full_messages, status: :not_accepted }
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
    render json: { timeline: TimelineSerializer.new(@user) }
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :fullnameviewable, :username, :email, :password, :password_confirmation, :gender, :city, :cityviewable, :about)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end