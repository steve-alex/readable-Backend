class Api::LikesController < ApplicationController
  before_action :set_like, only: [:destroy]

  def create
    like = Like.create(like_params)
    like.update(user: @current_user)
    if like.valid?
      render json: { like: like, status: 202 }
    else
      render json: { errors: like.errors.full_messages, status: 400 }
    end
  end

  def destroy
    @like.destroy
    render json: { message: "Deleted like", status: 204}
  end

  private

  def like_params
    params.require(:like).permit(:likeable_type, :likeable_id)
  end

  def set_like
    @like = Like.find_by(id: params[:id])
  end
end
