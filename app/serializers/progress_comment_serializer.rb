class ProgressCommentsSerializer
  
  def initialize(progress, current_user)
    @progress = progress
    @current_user = current_user
  end

  def serialize_as_json
    { 
      progress_id: @progress.id,
      current_user_likes: @current_user.likes_post?(@progress),
      comments: @progress.display_comments(current_user)
    }
  end
  
end