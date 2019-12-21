class Api::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  require "#{Rails.root}/app/serializers/comment_serializer.rb"

  def create
    comment = Comment.create(comment_params)
    if comment.valid?
      render json: { comment: CommentSerializer.new(comment).serialize_as_json, status: :ok }
    else
      render json: { errors: comment.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    render json: { comment: CommentSerializer.new(@comment).serialize_as_json, status: :ok }
  end

  def destroy
    @comment.destroy
    render json: { message: "Deleted comment", status: :ok}
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_type, :commentable_id)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end
end