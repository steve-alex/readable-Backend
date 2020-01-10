class Review < ApplicationRecord
  belongs_to :user
  belongs_to :copy
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

  validates :summary,
    length: { maximum: 128, message: "Summary must be shorter than 128 characters."}

  validates :content, {
    length: { maximum: 1028, message: "Content must be shorter than 1028 characters."},
    presence: true
  }

  validates :sentiment, {
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100,
      message: "Sentiment must be an integer between 0 and 100"
    },
    presence: true
  }

  validates :rating, {
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 5,
      message: "Sentiment must be an integer between 0 and 5"
    },
    presence: true
  }

  def most_liked_comment
    self.comments.sort_by{ |comments| comment.like_count }
  end

  def display_comments(current_user)
    self.comments.map{ |comment|
      {
        id: comment.id,
        content: comment.content,
        user_id: comment.user.id,
        username: comment.user.username,
        user_avatar: comment.user.get_avatar_url,
        created_at: comment.created_at,
        likes: comment.likes,
        time_since_upload: comment.time_since_upload,
        current_user_likes: comment.current_user_likes?(current_user)
      }
    }
  end

end