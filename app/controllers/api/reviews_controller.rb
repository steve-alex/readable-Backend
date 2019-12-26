class Api::ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy, :comments]
  require "#{Rails.root}/app/serializers/review_serializer.rb"
  require "#{Rails.root}/app/serializers/post_comments_serializer.rb"

  def create
    current_user = set_current_user()
    copy = current_user.find_copy_by_book_id(params[:book_id])
    if copy[0]
      review = Review.create(
        content: params[:content],
        rating: params[:rating],
        sentiment: params[:sentiment],
        user_id: params[:user_id],
        copy_id: copy[0].id
      )
      if review.valid?
        render json: { review: ReviewSerializer.new(review).serialize_as_json, status: :ok }
      else
        render json: { errors: review.errors.full_messages, status: :not_accepted }
      end
    else
      render json: { errors: "Add this book to a shelf to leave a review", status: :not_accepted }
    end
  end
  
  def show
    render json: { review: ReviewSerializer.new(@review, @current_user).serialize_as_json }
  end
  
  def update
    if @review.update(review_params)
      render json: { review: ReviewSerializer.new(@review).serialize_as_json, message: "Updated review", status: :ok}
    else
      render json: { message: @review.errors.full_messages, status: :not_accepted}
    end
  end
  
  def destroy
    @review.destroy
    render json: { message: "Deleted review", status: :ok}
  end

  def comments
    if @review
      render json: { comments: PostCommentsSerializer.new(@review, @current_user).serialize_as_json, message: "Comments recieved", status: :ok}
    else
      render json: { errors: "Not able to retrieve comments", status: :not_accepted}
    end
  end
  
  private

  def review_params
    params.require(:review).permit(:summary, :content, :rating, :sentiment, :user_id, :copy_id)
  end
  
  def set_review
    @review = Review.find(params[:id])
  end

end