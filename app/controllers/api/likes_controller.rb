class Api::LikesController < ApplicationController
  before_action :set_like, only: [:show, :update, :destroy]

  def create
    like = Like.create(like_params)
    if like.valid?
      render json: { like: like, status: :ok }
    else
      render json: { errors: like.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    render json: @like
  end

  def destroy
    @like.destroy
    render json: { message: "Deleted like", status: :ok}
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end

  def set_like
    @like = Like.find_by(id: params[:id])
  end
end
