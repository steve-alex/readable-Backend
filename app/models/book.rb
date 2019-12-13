class Book < ApplicationRecord
  has_many :shelf_books
  has_many :shelves, through: :shelf_books

  def reviews
    self.shelf_books.map{ |shelf_book| shelf_book.reviews }.flatten
  end

  def progresses
    self.shelf_books.map{ |shelf_book| shelf_book.progresses }.flatten
  end

  def most_appeared_on_shelves
    shelf_count_hash = {}
    shelf_names = self.shelf_books.map{ |shelf_book| shelf_book.shelf.name.downcase! }
    shelf_names.each { |shelf_name| 
      if shelf_count_hash[shelf_name]
        shelf_count_hash[shelf_name] += 1
      else
        shelf_count_hash[shelf_name] = 1
      end
    }
    shelf_count_hash.sort_by{ |key, value| value }
  end

  def currently_reading_count
    self.shelf_books.count{ |shelf_book| shelf_book.currently_reading == true }
  end
end