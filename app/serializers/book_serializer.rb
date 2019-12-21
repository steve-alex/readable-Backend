class BookSerializer

  def initialize(book)
    @book = book
  end

  def serialize_as_json
    {
      id: book.id,
      google_id: book.google_id,
      title: book.title,
      subtitle: book.subtitle,
      authors: book.authors,
      categories: book.authors,
      description: book.description,
      language: book.language,
      image_url: book.image_url,
      published_date: book.published_date,
      page_count: book.page_count,
      google_average_rating: book.google_average_rating,
      rating_count: book.rating_count
    }
  end
  
end