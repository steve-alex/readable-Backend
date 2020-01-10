class Book < ApplicationRecord
  has_many :copies

  validates :google_id,
    presence: true,
    uniqueness: true

  def reviews
    self.copies.map{ |copy| copy.reviews }.flatten
  end

  def review_distribution
    review_distribution = {1 => 0, 2 =>0, 3 => 0, 4 =>0, 5 =>0}
    self.reviews.each{ |review|
      rating = review.rating
      review_distribution[rating] += 1
    }
    review_distribution
  end

  def current_users_reviews(current_user)
    self.reviews.select{ |review| review.user_id == current_user.id }
  end

  def followed_users_reviews(current_user)
    followed_user_ids = current_user.followed.map{ |user| user.id }
    self.reviews.select{ |review| followed_user_ids.include?(review.user_id)}
  end

  def get_current_users_copy(user)
    user.copies.select{ |copy| copy.book_id == self.id }
  end

  def followed_users_with_book(user)
    followed_users_copies = user.followed.select{ |user| user_has_book(user) }
  end

  def user_has_book(user)
    copies = user.copies.select{ |copy| copy.book_id == self.id }
    if copies[0]
      return true
    else
      return false
    end
  end

  # def most_appeared_on_shelves
  #   shelf_count_hash = {}
  #   shelf_names = self.shelves.map{ |shelf| shelf.name.downcase! }
  #   shelf_names.each { |shelf_name| 
  #     if shelf_count_hash[shelf_name]
  #       shelf_count_hash[shelf_name] += 1
  #     else
  #       shelf_count_hash[shelf_name] = 1
  #     end
  #   }
  #   shelf_count_hash.sort_by{ |key, value| value }
  # end

end