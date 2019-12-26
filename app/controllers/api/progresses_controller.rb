class Api::ProgressesController < ApplicationController
  before_action :set_progress, only: [:show, :update, :destroy, :comments]
  require "#{Rails.root}/app/serializers/progress_serializer.rb"
  require "#{Rails.root}/app/serializers/progress_comment_serializer.rb"

  def create
    @progress = Progress.create(progress_params)
    if progress.valid?
      render json: { progress: ProgressSerializer.new(@progress, @current_user).serialize_as_json, status: :ok }
    else
      render json: { errors: @progress.errors.full_messages, status: :not_accepted }
    end
  end
  
  def show
    if @progress
      render json: { progress: ProgressSerializer.new(@progress, @current_user).serialize_as_json, status: :ok }
    else
      render json: { errors: @progress.errors.full_messages, status: :not_accepted }
    end
  end
  
  def update
    if @progress.update(progress_params)
      render json: { progress: ProgressSerializer.new(@progress, @current_user).serialize_as_json, message: "Updated progress", status: :ok}
    else
      render json: { errors: @progress.errors.full_messages, status: :not_accepted}
    end
  end

  def destroy
    @progress.destroy
    render json: { message: "Deleted progress", status: :ok}
  end

  def comments
    if @progress
      render json: { comments: PostCommentsSerializer.new(@progress, @current_user).serialize_as_json, message: "Comments recieved", status: :ok }
    else
      render json: { errors: "Unable to retrieve comments", status: :not_accepted }
    end
  end

  def submit
    byebug
    @progress = @current_user.get_latest_progress
    @progress.update(published: true, content: params[:content])
    Progress.create(published: false, user_id: @current_user.id)
    if @progress
      render json: { progress: ProgressSerializer.new(@progress, @current_user).serialize_as_json, status: :ok }      
    else
      render json: { errors: "Unable to submit progress", status: :not_accepted }
    end
  end
  
  private

  def progress_params
    params.require(:progress).permit(:user_id, :content, :published)
  end
  
  def set_progress
    @progress = Progress.find(params[:id])
  end
end