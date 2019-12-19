class TimelineSerializer < ActiveModel::Serializer
  attributes :user, :currently_reading, :timeline_posts

  def user
    current_user = object
    {
      id: current_user.id,
      fullname: current_user.id,
      username: current_user.username,
      email: current_user.email,
      gender: current_user.gender,
      city: current_user.city,
      about: current_user.about
    }
  end

  def currently_reading
    current_user = object
    current_user.currently_reading_books
  end

  def timeline_posts
    current_user = object
    current_user.timeline_posts
  end

end

#What are the custom methods under the attribute doing under the timline serializer 