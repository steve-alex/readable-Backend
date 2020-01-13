class UserSerializer
  def initialize(user)
    @user = user
  end

  def serialize_as_json
    {
      id: @user.id,
      avatar: @user.get_avatar_url,
      fullname: get_fullname(),
      username: @user.username,
      email: @user.email, 
      gender: @user.gender, 
      city: get_city(),
      about: @user.about,
      followers: @user.followers.length,
      following: @user.followed.length,
      book_count: @user.copies.length,
      shelves: @user.shelves,
      updates_by_copy: @user.get_updates_by_copy
    }
  end

  def get_fullname
    @user.fullnameviewable ? @user.fullname : nil
  end

  def get_city
    @user.cityviewable ? @user.city : nil
  end

end