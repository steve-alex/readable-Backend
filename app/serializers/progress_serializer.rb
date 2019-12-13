class ProgressSerializer < ActiveModel::Serializer
  attributes :id, :current_page, :total_pages, :user_id, :shelf_book_id, :created_at, :updated_at, :user, :book
  has_many :likes
  has_many :comments

  def user
    progress = object
    {
      username: object.user.username
    }
  end

  def book
    book = object.shelf_book.book
    {
      id: book.id,
      google_id: book.google_id,
      title: book.title,
      subtitle: book.subtitle,
      authors: book.authors,
      categories: book.categories,
      description: book.description,
      page_count: book.page_count
    }
  end

end