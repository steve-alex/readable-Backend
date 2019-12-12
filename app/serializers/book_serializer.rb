class BookSerializer < ActiveModel::Serializer
  attributes :data, :shelf_books

  def data
    book = object
    {
      id: book.id,
      google_id: book.google_id,
      title: book.title,
      subtitle: book.subtitle,
      authors: authors(),
      categories: categories(),
      description: book.description,
      language: book.language,
      image_url: book.image_url,
      published_date: book.published_date,
      page_count: book.page_count,
      google_average_rating: book.google_average_rating,
      rating_count: book.rating_count
    }
  end

  def shelf_books
    book = object
    shelf_books = book.shelf_books
    shelf_books.map{ |shelf_book| {
      id: book.id,
      shelf_book_names: book.most_appeared_on_shelves,
      currently_reading_count: book.currently_reading_count,
      reviews: book.reviews
    }}
    #object.shelf_books
  end

  def community_reviews
    book = object
  end

  def authors
    object.authors
  end

  def categories
    object.categories
  end

  def language
    object.language
  end

end