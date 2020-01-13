class Api::UpdatesController < ApplicationController
  before_action :set_update, only: [:destroy]

  def create
    current_user = set_current_user
    progress = current_user.get_latest_progress
    update = Update.create(
      progress_id: progress.id,
      copy_id: params[:copy_id],
      page_number: params[:page_number]
    )
    if update.valid?
      render json: {update: UpdateSerializer.new(update).serialize_as_json, status: 204}
    else
      render json: {errors: review.errors.full_messages, status: 400}
    end
  end

  def destroy
    @update.destroy
    render json: {message: "Deleted update", status: 204}
  end
  
  private

  def update_params
    params.require(:update).permit(:user_id, :content, :published)
  end
  
  def set_update
    @update = Update.find_by(id: params[:id])
  end
  
end
