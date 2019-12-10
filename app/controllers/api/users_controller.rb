class Api::UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.valid?
            render json: {user: UserSerializer.new(user), token: issue_token({ user_id: user.id })}
        else
            render json: user.errors.full_messages, status: :not_accepted
        end
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end
end