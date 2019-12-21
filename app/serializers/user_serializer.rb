class UserSerializer
  def initialize(user)
    @user = user
  end

  def serialize_as_json
    {
      id: @user.id,
      id: @user.id,
      fullname: get_fullname(),
      username: @user.username,
      email: @user.email, 
      gender: @user.gender, 
      city: get_city(),
      about: @user.about,
      followers: @user.followers.length,
      following: @user.followed.length,
      shelves: @user.shelves
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