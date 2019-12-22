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
      sentiment: @review.sentiment,
      book: {
        id: @review.copy.book.id,
        google_id: @review.copy.book.google_id,
        title: @review.copy.book.title,
        subtitle: @review.copy.book.subtitle,
        authors: @review.copy.book.authors,
        categories: @review.copy.book.categories,
        description: @review.copy.book.description,
        image_url: @review.copy.book.image_url
      },
      user: {
        id: @review.user.id,
        username: @review.user.username,
        avatar: @review.user.get_avatar_url
      },
      likes: @review.likes,
      comments: @review.display_comments,
      created_at: @review.created_at
    }
  end
  
end