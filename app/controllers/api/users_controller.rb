class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def create
    user = User.create(user_params)
    if user.valid?
      render json: {user: UserSerializer.new(user), token: issue_token({ user_id: user.id })}
    else
      render json: user.errors.full_messages, status: :not_accepted
    end
  end

  def show
    render json: user
  end

  def update
    if @user.update(user_params)
      render json: { message: "Updated user details", status: :ok}
    else
      render json: { message: "Unable to update user details", status: :service_unavailable}
    end
  end

  def destroy
    @user.destroy
    render json: { message: "Deleted User", status: :ok}
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :fullnameviewable, :username, :email, :password, :password_confirmation, :gender, :city, :cityviewable, :about)
  end

  def set_user
    @user = User.find(user_params)
  end
end