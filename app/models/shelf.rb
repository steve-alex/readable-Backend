class Shelf < ApplicationRecord
  belongs_to :user
  has_many :shelfBooks
  has_many :books, through: :shelfBooks
  has_many :reviews
  has_many :progresses
end
