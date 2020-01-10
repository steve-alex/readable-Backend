class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :likes, :as => :likeable

  validates :content, {
    length: {maximum: 900, message: "Content must be shorter than 900 characters."},
    presence: {message: "A comment must contain some content."}
  }

  def current_user_likes?(current_user)
    like = self.likes.find{|like| like.user_id == current_user.id }
    like ? like : false
  end
end