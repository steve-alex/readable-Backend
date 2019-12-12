class Book < ApplicationRecord
  has_many :shelf_books
  has_many :shelves, through: :shelf_books
end