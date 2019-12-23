class Api::UpdatesController < ApplicationController
  before_action :set_update, only: [:show, :update, :destroy]

  def create
    current_user = set_current_user
    progress = current_user.get_latest_progress
    update = Update.create(
      progress_id: progress.id,
      copy_id: params[:copy_id],
      page_number: params[:page_number]
    )
    if update.valid?
      render json: { update: UpdateSerializer.new(update).serialize_as_json, status: :ok }
    else
      render json: { errors: review.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    if update
      render json: { update: UpdateSerializer.new(update).serialize_as_json, status: :ok }
    else
      render json: {errors: update.errors.full_messages, status: :not_accepted}
    end
  end
  
  def update
    if @update.update(update_params)
      render json: { update: UpdateSerializer.new(update).serialize_as_json, message: "Updated progress", status: :ok}
    else
      render json: { update: @progress, message: @update.errors.full_messages, status: :not_accepted}
    end
  end

  def destroy
    @update.destroy
    render json: { message: "Deleted update", status: :ok}
  end
  
  private

  def update_params
    params.require(:update).permit(:user_id, :content, :published)
  end
  
  def set_update
    @update = Update.find_by(id: params[:id])
  end
  
end
