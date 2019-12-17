class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :shelf_book
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

  def most_liked_comment
    self.comments.sort_by{ |comments| comment.like_count }
  end
end