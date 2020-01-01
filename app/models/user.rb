class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_secure_password
  has_one_attached :avatar
  has_many :shelves
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

  def self.search_for_users(search_term)
    search_term = search_term.downcase
    User.all.select{ |user|
      user.username.downcase.include?(search_term) ||
      user.fullname.downcase.include?(search_term) ||
      user.email.downcase.include?(search_term)
    }
  end

  def following?(user)
    self.followed.include?(user)
  end

  def follow_object(user)
    self.follows_as_follower.select{|follow| follow.followed_id == user.id}.flatten
  end

  def posts
    posts = Array(self.reviews).concat(Array(self.progresses.where(published: true))).flatten
    posts.sort_by{ |post| post.created_at }.reverse!
  end

  def timeline_posts
    followed_users_posts = self.followed.map{ |user| user.posts }.flatten
    followed_users_posts.sort_by{ |post| post.created_at }.reverse!
  end

  def copies
    self.shelves.map{ |shelf| shelf.copies }.flatten.uniq
  end

  def currently_reading
    copies = self.copies.select{ |copy| copy.currently_reading == true }
    copies.map{ |copy| 
      {
        id: copy.id,
        book_id: copy.book.id,
        image_url: copy.book.image_url,
        title: copy.book.title
      }  
    }
  end
  
  def books
    self.shelves.map{ |shelf| shelf.books }.flatten.uniq
  end

  def shelves_containing_book(book)
    self.shelves.select{ |shelf| shelf.books.include?(book) }
  end

  def find_copy_by_book_id(book_id)
    self.copies.select{ |copy| copy.book_id == book_id }
  end

  def get_latest_progress
    self.progresses.where(published: false)[0]
  end

  def latest_rating_of_book(copy)
    self.reviews.select{ |review| review.copy_id == copy.id }.sort_by{|review| review.created_at}[0]
  end

  def profile_shelf_display
    profile_shelf_display = {}
    self.shelves.each{ |shelf|
      copies = shelf.copies.shuffle
      profile_shelf_display[shelf.name] = {
        shelf_id: shelf.id,
        book_count: shelf.copies.length,
        books_to_display: get_books_to_display(copies)
      }
    }
    profile_shelf_display
  end

  def get_updates_by_copy
    currently_reading = self.copies.filter{ |copy| copy.currently_reading == true }
    if currently_reading[0]
      updates_by_copy = currently_reading.map{ |copy| 
        {
          copy_id: copy.id,
          book_id: copy.book.id,
          title: copy.book.title,
          page_count: copy.book.page_count,
          subtitle: copy.book.subtitle,
          authors: copy.book.authors,
          currently_reading: copy.currently_reading,
          image_url: copy.book.image_url,
          updates: copy.display_updates
        }
      }
      else
        updates_by_copy = false
      end
      updates_by_copy
  end

  def get_books_to_display(copies)
    copies.map{ |copy| 
      {
        copy_id: copy.id,
        book_id: copy.book.id,
        title: copy.book.title,
        image_url: copy.book.image_url
      }
    }
  end

  def genres
    books = self.shelves.map{ |shelf| shelf.books }.flatten
    genres = books.map{ |book| book.categories }
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

  def genre_match(user)
    if self.id === user.id
      return false
    end
    current_users_favourite_genres = self.build_genres_hash
    other_users_favourite_genres = user.build_genres_hash
    other_users_favourite_genres.delete(nil)

    similar_genres = {}
    different_genres = {}

    other_users_favourite_genres.each do |genre, count|
      if current_users_favourite_genres[genre]
        similar_genres[genre] = current_users_favourite_genres[genre] + other_users_favourite_genres[genre]
      else
        different_genres[genre] = other_users_favourite_genres[genre]
      end
    end

    s = similar_genres.sort_by{|key, value| -value}.map{ |genre| 
      genre[0]
    }
    d = different_genres.sort_by{|key, value| -value}.map{ |genre| 
      genre[0]
    }
    t = s[0, 4]
    e = d[0, 4]

    return [t, e]
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

  def safe_update(params)
    self.avatar.purge
    self.avatar.attach(params[:file])
    self.update(
      fullname: params[:fullname],
      fullnameviewable: params[:fullnameviewable],
      username: params[:username],
      gender: params[:gender],
      city: params[:city],
      cityviewable: params[:cityviewable],
      about: params[:about]
    )
  end

  def get_avatar_url
    url_for(self.avatar)
  end

  def create_default_avatar
    self.avatar.purge
    self.avatar.attach(io: File.open(Rails.root.join('config', 'user.png')), filename: 'user.png', content_type: 'image/png')
  end

  def likes_post?(post)  
    like = self.likes.find{|like| like.likeable_id == post.id && like.likeable_type == post.class.name}
    if like
      return like
    end
    false
  end

end