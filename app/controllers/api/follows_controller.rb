class Api::FollowsController < ApplicationController
  before_action :set_follow, only: [:destroy]

  def create
    follow = Follow.create(follower_id: @current_user.id, followed_id: params[:id])
    if follow.valid?
      render json: {follow: follow, status: 201}
    else
      render json: {errors: follow.errors.full_messages, status: 400}
    end
  end

  def destroy
    @follow.destroy
    render json: {message: "Deleted follow", status: 204}
  end

  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end

  def set_follow
    @follow = Follow.find_by(id: params[:id])
  end
end
