class BookSerializer < ActiveModel::Serializer
  attributes :id, :google_id, :title, :subtitle, :authors, :categories, :description, :language, :image_url, :published_date, :page_count, :google_average_rating, :rating_count
  has_many :shelf_books

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