class Api::FollowsController < ApplicationController
  before_action :set_follow, only: [:show, :update, :destroy]

  def create
    follow = Follow.create(follow_params)
    if follow.valid?
      render json: { follow: follow, status: :ok }
    else
      render json: { errors: follow.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    render json: @follow
  end

  def destroy
    @follow.destroy
    render json: { message: "Deleted follow", status: :ok}
  end

  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end

  def set_follow
    @follow = Follow.find_by(id: params[:id])
  end
end
