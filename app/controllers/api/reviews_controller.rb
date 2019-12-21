class Api::ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy]

  def create
    current_user = set_current_user
    review = Review.create(reviews_params)
    if review.valid?
      render json: { review: ReviewSerializer.new(review), status: :ok }
    else
      render json: { errors: review.errors.full_messages, status: :not_accepted }
    end
  end
  
  def show
    render json: { review: ReviewSerializer.new(@review) }
  end
  
  def update
    if @review.update(review_params)
      render json: { review: ReviewSerializer.new(@review), message: "Updated review", status: :ok}
    else
      render json: { message: @review.errors.full_messages, status: :not_accepted}
    end
  end
  
  def destroy
    @review.destroy
    render json: { message: "Deleted review", status: :ok}
  end
  
  private

  def review_params
    params.require(:review).permit(:summary, :content, :rating, :sentiment, :user_id, :copy_id)
  end
  
  def set_review
    @review = Review.find_by(id: params[:id])
  end

end