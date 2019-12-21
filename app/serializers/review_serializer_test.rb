class ReviewSerializer

  def initialize(review)
    @review = review
  end

  def serialize_as_json
    {
      id: @review.id,
      copy_id: @review.copy.id,
      summary: @review.summary,
      content: @review.content,
      rating: @review.rating,
      sentiment: @review.sentiment
      user: {
        id: @review.user.id,
        username: @review.user.username,
        avatar: @review.user.avatar
      },
      likes: @review.likes,
      comments: @review.display_comments,
      created_at: @review.created_at
    }
  end
  
end