class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelf_book
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

  validates :content, {
    length: { maximum: 2000 }
  }

  validates :sentiment, {
    numericality: true
  }
end
