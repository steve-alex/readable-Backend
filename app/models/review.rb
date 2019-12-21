class Review < ApplicationRecord
  belongs_to :user
  belongs_to :copy
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

  validates :content, {
    length: { maximum: 2000 }
  }

  validates :sentiment, {
    numericality: {
      less_than_or_equal_to: 100,
      only_integer: true
    }
  }

  validates :rating, {
    numericality: {
      less_than_or_equal_to: 5,
      only_integer: true
    }
  }

  def most_liked_comment
    self.comments.sort_by{ |comments| comment.like_count }
  end

  def display_comments
    self.comments.map{ |comment|
      {
        id: comment.id,
        content: comment.content,
        user_id: comment.content,
        username: comment.user.username,
        user_avatar: comment.user.avatar,
        created_at: comment.created_at
      }
    }
  end

end