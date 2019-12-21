class CommentSerializer

  def initialize(comment)
    @comment = comment
  end

  def serialize_as_json
    {
      id: @comment.id,
      content: @comment.content, 
      user_id: @comment.user_id,
      commentable: @comment.commentable,
      user: {
        id: @comment.user.id,
        username: @comment.user.username,
        avatar: @comment.user.avatar
      },
      likes: @comment.likes,
      created_at: @comment.created_at,
      updated_at: @comment.updated_at
    }
  end
  
end