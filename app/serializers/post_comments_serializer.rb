class PostCommentsSerializer
  
  def initialize(post, current_user)
    @post = post
    @current_user = current_user
  end

  def serialize_as_json
    {
      review_id: @post.id,
      comments: @post.display_comments(@current_user)
    }
  end
  
end