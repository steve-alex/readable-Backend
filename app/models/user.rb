class User < ApplicationRecord
  has_secure_password
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

  validates :fullname, :username, :email, {
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

  def shelves_containing_book(book)
    self.shelves.select{ |shelf|
      shelf_ids = shelf.books{ |book| book.id }
      shelf_ids.include?(book)
    }
  end

  def unique_books
    self.shelf_books.uniq{ |shelf_book| shelf_book.book.google_id }
  end

  def profile_shelf_display
    self.shelves.map{|shelf|
      books = shelf.books
      {
        shelf.name => {
            image_urls: books.shuffle.slice(0, 4).map{ |book| book.image_url},
            book_count: books.length
        }
      }
    }
  end

  def books
    books = self.shelves.map{ |shelf| shelf.books }.flatten.uniq
  end

  def genres
    genres = self.books.map{ |book| book.categories }.uniq
  end

  def books_in_common(current_user)
    if current_user.id == self.id
      return "Current User"
    end
    self.books & current_user.books
  end

  def favourite_genres
    genres_hash = build_genres_hash()
    genres_hash.sort_by{|key, value| -value}
  end

  def favourite_authors
    authors_hash = build_authors_hash()
    authors_hash.sort_by{|key, value| -value}
  end

  def build_genres_hash
    genres_hash = {}
    self.books.each{ |book| 
      genre = book.categories
      if genres_hash[genre]
        genres_hash[genre] += 1
      else
        genres_hash[genre] = 1
      end
    }
    genres_hash
  end

  def build_authors_hash
    authors_hash = {}
    self.books.each{ |book| 
      author = book.authors
      if authors_hash[author]
        authors_hash[author] += 1
      else
        authors_hash[author] = 1
      end
    }
    authors_hash
  end

end