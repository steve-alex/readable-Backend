class PostCommentsSerializer
  
  def initialize(post, current_user)
    @post = post
    @current_user = current_user
  end

  def serialize_as_json
    {
      review_id: @post.id,
      comments: @post.display_comments(@current_user),
      current_user_likes: @current_user.likes_post?(@post),
      time_since_upload: @post.time_since_upload
    }
  end
  
end