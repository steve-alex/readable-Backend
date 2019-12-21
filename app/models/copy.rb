class Copy < ApplicationRecord
  belongs_to :book
  has_many :shelf_copies
  has_many :shelves, through: :shelf_copies
  has_many :updates
  has_many :progresses, through: :updates
  has_many :reviews

end