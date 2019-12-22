class Progress < ApplicationRecord
  belongs_to :user
  has_many :updates
  has_many :copies, through: :updates
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

  # validates :status, {
  #   ##Find a way of making this less that the actual book that you are reviewing
  #   ##Could just do it on the front end, or give the number of pages for the review
  #   ##Need to deal with user giving the status lower than the current status, consider all the cases
  #   numericality: true
  # }
  # before_create do
  #   self.
  # end
  def books
    self.copies.map{ |copy| copy.book }.uniq
  end


  def most_liked_comment
    self.comments.sort_by{ |comments| comment.like_count }
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
        updates: copy.updates.reverse
      }
    }
  end

  def display_comments
    self.comments.map{ |comment|
      {
        id: comment.id,
        content: comment.content,
        user_id: comment.content,
        username: comment.user.username,
        user_avatar: comment.user.get_avatar_url,
        created_at: comment.created_at,
        likes: comment.likes
      }
    }
  end

end