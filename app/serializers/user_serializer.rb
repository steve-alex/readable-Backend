class UserSerializer < ActiveModel::Serializer
  attributes :data, :shelves, :currently_reading, :reviews, :progresses

  def data
    {
      id: object.id,
      fullname: get_fullname(),
      username: object.username,
      email: object.email, 
      gender: object.gender, 
      city: get_city(),
      about: object.about,
      followers: object.followers.length,
      following: object.followed.length,
      book_count: object.unique_books.length
    }
  end

  def shelves
    object.shelves.sort_by{ |shelf| shelf.updated_at }
  end

  def currently_reading
    object.currently_reading_books
  end

  def reviews
    object.reviews.sort_by{ |review| review.created_at }.reverse!
  end

  def progresses
    object.progresses.sort_by{ |progress| progress.created_at }.reverse!
  end

  def get_fullname
    if object.fullnameviewable
      return object.fullname
    end
    nil
  end

  def get_city
    if object.cityviewable
      return object.city
    end
    nil
  end

end