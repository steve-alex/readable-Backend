class Api::ProgressController < ApplicationController
  before_action :set_progress, only: [:show, :update, :destroy]

  def create
    progress = Progress.create(progress_params)
    if progress.valid?
      render json: { progress: progress, status: :ok }
    else
      render json: { errors: progress.errors.full_messages, status: :not_accepted }
    end
  end
  
  def show
    render json: @progress
  end
  
  def update
    if @progress.update(progress_params)
      render json: { message: "Updated progress", status: :ok}
    else
      render json: { message: @progress.errors.full_messages, status: :not_accepted}
    end
  end

  def destroy
    @progress.destroy
    render json: { message: "Deleted progress", status: :ok}
  end
  
  private

  def review_params
    params.require(:progress).permit(:status, :user_id, :shelf_book_id)
  end
  
  def set_review
    @progress = Progress.find_by(id: params[:id])
  end
end
