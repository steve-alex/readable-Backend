class Book < ApplicationRecord
  has_many :shelfBooks
  has_many :shelves, through: :shelfBooks
end