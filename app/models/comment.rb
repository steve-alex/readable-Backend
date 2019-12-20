class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  # has_many :comments, :as => :commentable 
  has_many :likes, :as => :likeable

  validates :content, {
    length: { maximum: 900,
      message: "Content cannot be longer than 900 characters"
    }
  }

  def like_count
    self.likes.length
  end
end