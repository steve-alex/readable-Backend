class User < ApplicationRecord
  has_many :shelves
  has_many :likes
  has_many :comments
  has_many :reviews
  has_many :progresses
  #Does a user need to have many reviews and progresses?
end
