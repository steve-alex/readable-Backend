class Book < ApplicationRecord
  has_many :shelf_books
  has_many :shelves, through: :shelf_books

  def reviews
    self.shelf_books.map{ |shelf_book| shelf_book.reviews }.flatten
  end

  def progressses

  end

  def most_appeared_on_shelves
    ##Make this the count of shelfs
    self.shelf_books.map{ |shelf_book| shelf_book.shelf.name }.uniq
  end

  def currently_reading_count
    self.shelf_books.count{ |shelf_book| shelf_book.currently_reading == true }
  end
end