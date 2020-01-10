class Progress < ApplicationRecord
  belongs_to :user
  has_many :updates
  has_many :copies, through: :updates
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

  validates :content,
    length: { maximum: 256, message: "Content must be shorter than 256 characters."}

  def books
    self.copies.map{ |copy| copy.book }.uniq
  end

  def most_liked_comment
    self.comments.sort_by{ |comment| comment.likes.length }[0]
  end

  def display_updates_by_book
    self.copies.uniq.map{ |copy|
      {
        copy_id: copy.id,
        book_id: copy.book.id,
        title: copy.book.title,
        subtitle: copy.book.subtitle,
        image_url: copy.book.image_url,
        authors: copy.book.authors,
        page_count: copy.book.page_count,
        updates: copy.display_updates_for_progress(self.id)
      }
    }
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