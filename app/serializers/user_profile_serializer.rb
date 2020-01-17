class UserProfileSerializer
  require "#{Rails.root}/app/serializers/timeline_serializer.rb"

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
        book_count: @user.copies.length,
        avatar: @user.get_avatar_url
      },
      posts: TimelineSerializer.new(@user, true).serialize_as_json(),
      shelves: @user.profile_shelf_display,
      genres: @user.genres,
      genre_match: @user.genre_match(@current_user),
      updates_by_copy: @user.get_updates_by_copy,
      books_in_common: @user.books_in_common(@current_user),
      follow_object: @current_user.follow_object(@user)
    }
  end

  def get_fullname
    @user.fullnameviewable ? @user.fullname : nil
  end

  def get_city
    @user.cityviewable ? @user.city : nil
  end

end