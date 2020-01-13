class Api::CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  require "#{Rails.root}/app/serializers/comment_serializer.rb"

  def create
    comment = Comment.create(comment_params)
    comment.update(user_id: @current_user.id)
    if comment.valid?
      render json: {comment: CommentSerializer.new(comment, @current_user).serialize_as_json, status: 201}
    else
      render json: {errors: comment.errors.full_messages, status: 400}
    end
  end

  def destroy
    @comment.destroy
    render json: {message: "Deleted comment", status: 204}
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_type, :commentable_id)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end
end