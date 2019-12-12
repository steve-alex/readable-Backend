class User < ApplicationRecord
  has_many :shelves
  has_many :shelf_books, through: :shelves
  has_many :likes
  has_many :comments
  has_many :reviews
  has_many :progresses

  has_many :follows_as_follower, foreign_key: "follower_id", class_name: :Follow, dependent: :destroy
  has_many :followed, through: :follows_as_follower, class_name: :User
  
  has_many :follows_as_followed, foreign_key: "followed_id", class_name: :Follow, dependent: :destroy
  has_many :followers, through: :follows_as_followed, class_name: :User

  validates :fullname, :username, :email, :password_digest, {
    presence: true
  }

  validates :about, {
    length: { maximum: 380,
      message: "About section cannot be longer than 380 characters"
    }
  }

  # validates :fullname {
  #       format: {
  #     USERNAMEREX
  #   }
  # }

  validates :username, {
    uniqueness: true
    # format: {
    #   USERNAMEREX
    # }
  }

  validates :email, {
    uniqueness: true
    # format: {
    #   EMAILREGEX
    # }
  }
  
  # validates :password {
  #   format: {
  #     PASSWORDREGEX
  #   }
  # }

  def posts
    posts = Array(self.reviews).concat(Array(self.progresses)).flatten
    posts.sort{ |post| post.created_at }
  end

  def timeline_posts
    followed_users_posts = self.followed.map{ |user| user.posts }.flatten
    followed_users_posts.sort_by{ |post| post.created_at }.reverse!
  end

  def currently_reading_books
    shelf_books = self.shelf_books.select{ |shelf_book| shelf_book.currently_reading == false }
    shelf_books.map{ |shelf_book| {
      id: shelf_book.id,
      currently_reading: shelf_book.currently_reading,
      book_id: shelf_book.book_id,
      shelf_id: shelf_book.shelf_id,
      created_at: shelf_book.created_at,
      updated_at: shelf_book.updated_at,
      progresses: shelf_book.progresses
      }
    }
  end

  def unique_books
    self.shelf_books.uniq{ |shelf_book| shelf_book.book.google_id }
  end

end