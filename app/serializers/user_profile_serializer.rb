class UserProfileSerializer

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
  end

  def serialize_as_json
    {
      user: {
        id: @user.id,
        fullname: get_fullname(),
        username: @user.username,
        email: @user.email, 
        gender: @user.gender, 
        city: get_city(),
        about: @user.about,
        follower_count: @user.followers.length,
        following_count: @user.followed.length,
        book_count: @user.unique_books.length
      },
      currently_readng: nil,
      shelves: @user.profile_shelf_display, 
      genres: @user.genres,
      favourite_genres: @user.favourite_genres,
      favourite_authors: @user.favourite_authors,
      books_in_common: @user.books_in_common(@current_user),
      follow_object: @current_user.follow_object(@user)    }
  end

  def get_fullname
    if @user.fullnameviewable
      return @user.fullname
    end
    nil
  end

  def get_city
    if @user.cityviewable
      return @user.city
    end
    nil
  end

end