class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelfBook
  has_many :likes, :as => :likeable
  has_many :comments, :as => :comments

  validates :content, {
    length: { maximum: 2000 }
  }

  validates :sentiment, {
    numericality: true
  }
end
