class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelfBook
  #Is this the right thing to do? Should this belong to multiple things?
  #Surely if it just belongs to a shelfBook, you'll be able to find which user it belongs to as well?
  has_many :likes, :as => :likeable
  has_many :comments, :as => :comments
end
