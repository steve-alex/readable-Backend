class User < ApplicationRecord
  # has_secure_password
  has_many :shelves
  has_many :shelfBooks, through: :shelves
  has_many :likes
  has_many :comments
  has_many :reviews
  has_many :progresses
end
