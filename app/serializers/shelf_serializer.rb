class ShelfSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :books

  def books
    object.shelf_books.map{ |shelf_book| {
        google_id: shelf_book.book.google_id,
        title: shelf_book.book.title,
        author: shelf_book.book.authors,
        image_url: shelf_book.book.image_url,
        google_rating: shelf_book.book.google_average_rating,
        date_added: shelf_book.created_at,
      }
    }
  end

end