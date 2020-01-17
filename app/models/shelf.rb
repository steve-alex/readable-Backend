class Shelf < ApplicationRecord
  belongs_to :user
  has_many :shelf_copies, dependent: :destroy
  has_many :copies, through: :shelf_copies

  validates :name, {
    length: {maximum: 42 , message: "Shelf names cannot be longer 42 characters"},
    uniqueness: {scope: :user, message: "Shelf names must be unique"}
  }
  
  def find_copy(copy_id)
    self.copies.select{ |copy| copy.id == copy_id }
  end

  def books
    self.copies.map{ |copy| copy.book }
  end

  def display_books(current_user)
    self.copies.map{ |copy| 
      {
        id: copy.book.id,
        google_id: copy.book.google_id,
        copy_id: copy.id,
        title: copy.book.title,
        author: copy.book.authors,
        image_url: copy.book.image_url,
        google_rating: copy.book.google_average_rating,
        created_at: copy.created_at,
        rating: current_user.latest_rating_of_book(copy)
      }
    }
  end

  def get_latest_copy
    self.copies[-1]
  end

end