class User < ApplicationRecord
  has_many :shelves
  has_many :shelf_books, through: :shelves
  has_many :likes
  has_many :comments
  has_many :reviews
  has_many :progresses

  # has_many :relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  # has_many :followed_users, through: :relationships, source: :followed

  # has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  # has_many :followers, through: :reverse_relationships, source: :follower

  has_many :follows_as_follower, foreign_key: "follower_id", class_name: :Follow, dependent: :destroy
  has_many :followed, through: :follows_as_follower, class_name: :User
  
  has_many :follows_as_followed, foreign_key: "followed_id", class_name: :Follow, dependent: :destroy
  has_many :followers, through: :follows_as_followed, class_name: :User

  validates :fullname, :username, :email, :password_digest, {
    presence: true
  }

  validates :about, {
    length: { maximum: 3,
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

end