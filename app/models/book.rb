class Book < ApplicationRecord
  has_many :shelf_books
  has_many :shelves, through: :shelf_books
  has_many :reviews

  def progresses
    self.shelf_books.map{ |shelf_book| shelf_book.progresses }.flatten
  end

  def most_appeared_on_shelves
    shelf_count_hash = {}
    shelf_names = self.shelves.map{ |shelf| shelf.name.downcase! }
    shelf_names.each { |shelf_name| 
      if shelf_count_hash[shelf_name]
        shelf_count_hash[shelf_name] += 1
      else
        shelf_count_hash[shelf_name] = 1
      end
    }
    shelf_count_hash.sort_by{ |key, value| value }
  end

  def currently_reading_count
    self.shelf_books.count{ |shelf_book| shelf_book.currently_reading == true }
  end

  def current_users_reviews(current_user)
    self.reviews.select{ |review| review.user_id == 1 }
  end

  def followed_users_reviews(current_user)
    followed_ids = current_user.followed.map{ |user| user.id }
    self.reviews.select{ |review| followed_ids.include?(review.user_id)}
  end

  def review_distribution
    review_distribution = {1 => 0, 2 =>0, 3 => 0, 4 =>0, 5 =>0}
    self.reviews.each{ |review|
      rating = review.rating
      review_distribution[rating] += 1
    }
    review_distribution
  end
  
end