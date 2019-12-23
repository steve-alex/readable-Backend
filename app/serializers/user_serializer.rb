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
      shelves: @user.shelves,
      currently_reading: @user.get_latest_progress.display_updates_by_book,
      updates_by_copy: @user.get_updates_by_copy
    }
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