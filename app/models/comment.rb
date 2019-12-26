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

  def current_user_likes?(current_user)
    like = self.likes.find{|like| like.user_id == current_user.id }
    if like
      return like
    end
    false
  end
end