class BookProfileSerializer

  def initialize(book, current_user)
    @book = book
    @current_user = current_user
  end

  def serialize_as_json
    {
      id: @book.id,
      google_id: @book.google_id,
      title: @book.title,
      subtitle: @book.subtitle,
      authors: authors(),
      categories: categories(),
      description: @book.description,
      language: @book.language,
      image_url: @book.image_url,
      published_date: @book.published_date,
      page_count: @book.page_count,
      google_average_rating: @book.google_average_rating,
      rating_count: @book.rating_count,
      metrics: {
        most_appeared_on_shelves: @book.most_appeared_on_shelves,
        currently_reading_count: @book.currently_reading_count,
        review_distribution: @book.review_distribution
      },
      current_users_reviews: current_users_reviews(),
      followed_users_reviews: followed_users_reviews()
    }
  end

  def current_users_reviews
    if @current_user
      return @book.current_users_reviews(@current_user)
    end
    nil
  end

  def followed_users_reviews
    if @current_user
      return @book.followed_users_reviews(@current_user)
    end
    nil
  end

  def authors
    @book.authors
  end

  def categories
    @book.categories
  end

  def language
    @book.language
  end

end