class Api::ReviewController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy]

  def create
    review = Review.create(review_params)
    if review.valid?
      render json: { review: review, status: :ok }
    else
      render json: { errors: review.errors.full_messages, status: :not_accepted }
    end
  end
  
  def show
    render json: @review
  end
  
  def update
    if @review.update(review_params)
      render json: { message: "Updated review", status: :ok}
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
    params.require(:review).permit(:content, :sentiment, :user_id, :shelf_book_id)
  end
  
  def set_review
    @review = Review.find_by(id: params[:id])
  end
end
