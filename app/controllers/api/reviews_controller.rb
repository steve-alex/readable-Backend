class Api::ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy]

  def create
    current_user = set_current_user
    review = Review.create(
      content: params[:content],
      rating: params[:rating],
      sentiment: params[:sentiment],
      user_id: current_user.id,
      book_id: params[:book_id]
    )
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
    params.require(:review).permit(:content, :rating, :sentiment, :user_id, :book_id)
  end
  
  def set_review
    @review = Review.find_by(id: params[:id])
  end


end