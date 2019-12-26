class CommentSerializer

  def initialize(comment, current_user)
    @comment = comment
    @current_user = current_user
  end

  def serialize_as_json
    {
      id: @comment.id,
      content: @comment.content, 
      user_id: @comment.user_id,
      commentable: @comment.commentable,
      current_user_likes: @comment.current_user_likes?(@current_user),
      user_avatar: @comment.user.get_avatar_url,
      username: @comment.user.username,
      user_id: @comment.user.id,
      likes: @comment.likes,
      created_at: @comment.created_at,
      updated_at: @comment.updated_at
    }
  end
  
end