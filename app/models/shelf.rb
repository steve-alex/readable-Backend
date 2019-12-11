class Shelf < ApplicationRecord
  belongs_to :user
  has_many :shelfBooks
  has_many :books, through: :shelfBooks
  has_many :reviews
  has_many :progresses

  validates :name, {
    length: { maximum: 42 ,
      message: "Shelf names cannot be longer 42 characters" }
  }

  validates :name, {
    uniqueness: { scope: :user,
      message: "Shelf names must be unique" }
  }
end
