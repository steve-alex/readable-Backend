class Shelf < ApplicationRecord
  belongs_to :user
  has_many :shelf_copies
  has_many :copies, through: :shelf_copies

  validates :name, {
    length: { maximum: 42 ,
      message: "Shelf names cannot be longer 42 characters" }
  }

  validates :name, {
    uniqueness: { scope: :user,
      message: "Shelf names must be unique" }
  }

end