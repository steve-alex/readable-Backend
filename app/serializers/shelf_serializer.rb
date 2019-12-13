class ShelfSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :books

  def books
    object.books.map{ |book| {
        google_id: book.google_id,
        title: book.title,
        author: book.authors,
        image_url: book.image_url,
        google_rating: book.google_average_rating,
        date_added: book.created_at,
      }
    }
  end

end